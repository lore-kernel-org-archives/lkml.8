Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB59C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9058E20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNpPOAKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgCEJaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:30:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41278 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCEJaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:30:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id v4so6081171wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 01:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+9811zmN3vsPSi192c11sQBpcyBBYCc41F34I36Atio=;
        b=oNpPOAKSxRMZ5hgT8Zj3TLPDwhFLwe3ceA46x9pgvdkU7uaO29GNGBEOE3JYe04Uzz
         KzyIiOM/Bpo4eszCdFPyuCllFsNSZDBuyrzN8wYBVDcPXSStKPFoePmGxHUjJxCxPxUA
         BU/fenhsXQNoTVphumsyVYJ23JouVQJVsVcgtmNsTlIT9PVk32/bP31BWa0iGiMlW8Oo
         GBYV7gKJR2Ji79A6lUOV2Yp9wWspNfkM0BQ08eAfyWOSpjL0omhBGwRLQo+Lf2sjeh+u
         fBG5+Ix4LoBRl2ZpwgaDczSHBemrBPZ5aFFldrk8CK1H1uE0sTa+gh0LUM0U88QUL52Q
         l9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+9811zmN3vsPSi192c11sQBpcyBBYCc41F34I36Atio=;
        b=Hfv2PTxUnaDUbJF5+zKKirXaSxtD4D0thdKyd5IEa67QO5ZEg4WP1XDiWsm7Fe0Gx8
         WWgh2tLI9fQJQW4UL/n5dr94bBLjqDkrzF/fx5SG/Q+LkmU7ac2WT5HppTnK3uv9YYgM
         R88aZ6cpfdDtrLbEKfFUuXY7BzIqGyN3gJWBjJSr1NhSkwZStLcxpdy6tTMy7Dhegocu
         q4iP3juTa7mGLJhvvfXGnLeoepLPwFZjb5Pv0Cc2RK+C/Ql5D8tHkNw9e7zmzcifCZmh
         YjdIgcCFQ4Mj2c/hqWxny9ruLDrB0H0LDajE4soUynrGrm6cApqOJNU0jiKDUgfHRNss
         Ixpg==
X-Gm-Message-State: ANhLgQ0iI5jftP+NqNfbxieJ1ML/JUNOtrV+Ni1U1rZH9+b7LwsAgE+J
        uzbmHtH/CVEWld/4cMe5kKnUfQ==
X-Google-Smtp-Source: ADFU+vuy23wzjDeMpLy09WXvv31Y1h6cDHSIv8TqHnJ188eolc64XC1gHdwkArYC+hcD9uLEurwfwQ==
X-Received: by 2002:a5d:53c8:: with SMTP id a8mr8759163wrw.238.1583400608317;
        Thu, 05 Mar 2020 01:30:08 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:3151:b3b6:32b9:e36c])
        by smtp.gmail.com with ESMTPSA id b24sm8346168wmj.13.2020.03.05.01.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Mar 2020 01:30:06 -0800 (PST)
Date:   Thu, 5 Mar 2020 10:30:03 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 5.6-rc3: WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380
 enqueue_task_fair+0x328/0x440
Message-ID: <20200305093003.GA32088@vingu-book>
References: <20200228163545.GA18662@vingu-book>
 <be45b190-d96c-1893-3ef0-f574eb595256@de.ibm.com>
 <49a2ebb7-c80b-9e2b-4482-7f9ff938417d@de.ibm.com>
 <ad0f263a-6837-e793-5761-fda3264fd8ad@de.ibm.com>
 <CAKfTPtCX4padfJm8aLrP9+b5KVgp-ff76=teu7MzMZJBYrc-7w@mail.gmail.com>
 <CAKfTPtD9b6o=B6jkbWNjfAw9e1UjT9Z07vxdsVfikEQdeCtfPw@mail.gmail.com>
 <2108173c-beaa-6b84-1bc3-8f575fb95954@de.ibm.com>
 <7be92e79-731b-220d-b187-d38bde80ad16@arm.com>
 <805cbe05-2424-7d74-5e11-37712c189eb6@de.ibm.com>
 <f28bc5ac-87fa-2494-29db-ff7d98b7372a@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f28bc5ac-87fa-2494-29db-ff7d98b7372a@de.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 04 mars 2020 à 20:59:33 (+0100), Christian Borntraeger a écrit :
> 
> On 04.03.20 20:38, Christian Borntraeger wrote:
> > 
> > 
> > On 04.03.20 20:19, Dietmar Eggemann wrote:
> >>> I just realized that this system has something special. Some month ago I created 2 slices
> >>> $ head /etc/systemd/system/*.slice
> >>> ==> /etc/systemd/system/machine-production.slice <==
> >>> [Unit]
> >>> Description=VM production
> >>> Before=slices.target
> >>> Wants=machine.slice
> >>> [Slice]
> >>> CPUQuota=2000%
> >>> CPUWeight=1000
> >>>
> >>> ==> /etc/systemd/system/machine-test.slice <==
> >>> [Unit]
> >>> Description=VM production
> >>> Before=slices.target
> >>> Wants=machine.slice
> >>> [Slice]
> >>> CPUQuota=300%
> >>> CPUWeight=100
> >>>
> >>>
> >>> And the guests are then put into these slices. that also means that this test will never use more than the 2300%.
> >>> No matter how much CPUs the system has.
> >>
> >> If you could run this debug patch on top of your un-patched kernel, it would tell us which task (in the enqueue case)
> >> and which taskgroup is causing that.
> >>
> >> You could then further dump the appropriate taskgroup directory under the cpu cgroup mountpoint
> >> (to see e.g. the CFS bandwidth data). 
> >>
> >> I expect more than one hit since assert_list_leaf_cfs_rq() uses SCHED_WARN_ON, hence WARN_ONCE.
> > 
> > That was quick. FWIW, I messed up dumping the cgroup mountpoint (since I restarted my guests after this happened).
> > Will retry. See the dmesg attached. 
> 
> New occurence (with just one extra debug line)

Could you try to add the patch below on top of dietmar's one so we will have the status of
each level of the hierarchy ?
The 1st level seems ok but something wrong happens while walking the hierarchy

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 69fc30db7440..9ccde775e02e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5331,14 +5331,17 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
        if (rq->tmp_alone_branch != &rq->leaf_cfs_rq_list) {
                char path[64];
+               se = &p->se;
 
-               cfs_rq = cfs_rq_of(&p->se);
+               for_each_sched_entity(se) {
+                       cfs_rq = cfs_rq_of(se);
 
-               sched_trace_cfs_rq_path(cfs_rq, path, 64);
+                       sched_trace_cfs_rq_path(cfs_rq, path, 64);
 
-               printk("CPU%d path=%s on_list=%d nr_running=%d p=[%s %d]\n",
-                      cpu_of(rq), path, cfs_rq->on_list, cfs_rq->nr_running,
+                       printk("CPU%d path=%s on_list=%d nr_running=%d throttled=%d p=[%s %d]\n",
+                      cpu_of(rq), path, cfs_rq->on_list, cfs_rq->nr_running, cfs_rq_throttled(cfs_rq),
                       p->comm, p->pid);
+               }
        }
 
        assert_list_leaf_cfs_rq(rq);


> 
> 
> 

> [    0.229052] Linux version 5.6.0-rc3+ (cborntra@m83lp52.lnxne.boe) (gcc version 9.2.1 20190827 (Red Hat 9.2.1-1) (GCC)) #159 SMP Wed Mar 4 20:36:45 CET 2020
> [    0.229055] setup: Linux is running natively in 64-bit mode
> [    0.229106] setup: The maximum memory size is 131072MB
> [    0.229113] setup: Reserving 1024MB of memory at 130048MB for crashkernel (System RAM: 130048MB)
> [    0.229202] cpu: 64 configured CPUs, 0 standby CPUs
> [    0.229271] cpu: The CPU configuration topology of the machine is: 0 0 4 2 3 10 / 4
> [    0.230115] Write protected kernel read-only data: 13524k
> [    0.230852] Zone ranges:
> [    0.230853]   DMA      [mem 0x0000000000000000-0x000000007fffffff]
> [    0.230854]   Normal   [mem 0x0000000080000000-0x0000001fffffffff]
> [    0.230855] Movable zone start for each node
> [    0.230856] Early memory node ranges
> [    0.230857]   node   0: [mem 0x0000000000000000-0x0000001fffffffff]
> [    0.230865] Initmem setup node 0 [mem 0x0000000000000000-0x0000001fffffffff]
> [    0.230866] On node 0 totalpages: 33554432
> [    0.230867]   DMA zone: 8192 pages used for memmap
> [    0.230867]   DMA zone: 0 pages reserved
> [    0.230868]   DMA zone: 524288 pages, LIFO batch:63
> [    0.244964]   Normal zone: 516096 pages used for memmap
> [    0.244965]   Normal zone: 33030144 pages, LIFO batch:63
> [    0.264910] percpu: Embedded 33 pages/cpu s97280 r8192 d29696 u135168
> [    0.264919] pcpu-alloc: s97280 r8192 d29696 u135168 alloc=33*4096
> [    0.264919] pcpu-alloc: [0] 000 [0] 001 [0] 002 [0] 003 
> [    0.264921] pcpu-alloc: [0] 004 [0] 005 [0] 006 [0] 007 
> [    0.264922] pcpu-alloc: [0] 008 [0] 009 [0] 010 [0] 011 
> [    0.264924] pcpu-alloc: [0] 012 [0] 013 [0] 014 [0] 015 
> [    0.264925] pcpu-alloc: [0] 016 [0] 017 [0] 018 [0] 019 
> [    0.264926] pcpu-alloc: [0] 020 [0] 021 [0] 022 [0] 023 
> [    0.264927] pcpu-alloc: [0] 024 [0] 025 [0] 026 [0] 027 
> [    0.264929] pcpu-alloc: [0] 028 [0] 029 [0] 030 [0] 031 
> [    0.264930] pcpu-alloc: [0] 032 [0] 033 [0] 034 [0] 035 
> [    0.264931] pcpu-alloc: [0] 036 [0] 037 [0] 038 [0] 039 
> [    0.264932] pcpu-alloc: [0] 040 [0] 041 [0] 042 [0] 043 
> [    0.264933] pcpu-alloc: [0] 044 [0] 045 [0] 046 [0] 047 
> [    0.264935] pcpu-alloc: [0] 048 [0] 049 [0] 050 [0] 051 
> [    0.264936] pcpu-alloc: [0] 052 [0] 053 [0] 054 [0] 055 
> [    0.264937] pcpu-alloc: [0] 056 [0] 057 [0] 058 [0] 059 
> [    0.264938] pcpu-alloc: [0] 060 [0] 061 [0] 062 [0] 063 
> [    0.264939] pcpu-alloc: [0] 064 [0] 065 [0] 066 [0] 067 
> [    0.264941] pcpu-alloc: [0] 068 [0] 069 [0] 070 [0] 071 
> [    0.264942] pcpu-alloc: [0] 072 [0] 073 [0] 074 [0] 075 
> [    0.264943] pcpu-alloc: [0] 076 [0] 077 [0] 078 [0] 079 
> [    0.264944] pcpu-alloc: [0] 080 [0] 081 [0] 082 [0] 083 
> [    0.264946] pcpu-alloc: [0] 084 [0] 085 [0] 086 [0] 087 
> [    0.264947] pcpu-alloc: [0] 088 [0] 089 [0] 090 [0] 091 
> [    0.264948] pcpu-alloc: [0] 092 [0] 093 [0] 094 [0] 095 
> [    0.264949] pcpu-alloc: [0] 096 [0] 097 [0] 098 [0] 099 
> [    0.264951] pcpu-alloc: [0] 100 [0] 101 [0] 102 [0] 103 
> [    0.264952] pcpu-alloc: [0] 104 [0] 105 [0] 106 [0] 107 
> [    0.264953] pcpu-alloc: [0] 108 [0] 109 [0] 110 [0] 111 
> [    0.264954] pcpu-alloc: [0] 112 [0] 113 [0] 114 [0] 115 
> [    0.264956] pcpu-alloc: [0] 116 [0] 117 [0] 118 [0] 119 
> [    0.264957] pcpu-alloc: [0] 120 [0] 121 [0] 122 [0] 123 
> [    0.264958] pcpu-alloc: [0] 124 [0] 125 [0] 126 [0] 127 
> [    0.264959] pcpu-alloc: [0] 128 [0] 129 [0] 130 [0] 131 
> [    0.264961] pcpu-alloc: [0] 132 [0] 133 [0] 134 [0] 135 
> [    0.264962] pcpu-alloc: [0] 136 [0] 137 [0] 138 [0] 139 
> [    0.264963] pcpu-alloc: [0] 140 [0] 141 [0] 142 [0] 143 
> [    0.264964] pcpu-alloc: [0] 144 [0] 145 [0] 146 [0] 147 
> [    0.264966] pcpu-alloc: [0] 148 [0] 149 [0] 150 [0] 151 
> [    0.264967] pcpu-alloc: [0] 152 [0] 153 [0] 154 [0] 155 
> [    0.264968] pcpu-alloc: [0] 156 [0] 157 [0] 158 [0] 159 
> [    0.264969] pcpu-alloc: [0] 160 [0] 161 [0] 162 [0] 163 
> [    0.264971] pcpu-alloc: [0] 164 [0] 165 [0] 166 [0] 167 
> [    0.264972] pcpu-alloc: [0] 168 [0] 169 [0] 170 [0] 171 
> [    0.264973] pcpu-alloc: [0] 172 [0] 173 [0] 174 [0] 175 
> [    0.264974] pcpu-alloc: [0] 176 [0] 177 [0] 178 [0] 179 
> [    0.264976] pcpu-alloc: [0] 180 [0] 181 [0] 182 [0] 183 
> [    0.264977] pcpu-alloc: [0] 184 [0] 185 [0] 186 [0] 187 
> [    0.264978] pcpu-alloc: [0] 188 [0] 189 [0] 190 [0] 191 
> [    0.264979] pcpu-alloc: [0] 192 [0] 193 [0] 194 [0] 195 
> [    0.264981] pcpu-alloc: [0] 196 [0] 197 [0] 198 [0] 199 
> [    0.264982] pcpu-alloc: [0] 200 [0] 201 [0] 202 [0] 203 
> [    0.264983] pcpu-alloc: [0] 204 [0] 205 [0] 206 [0] 207 
> [    0.264984] pcpu-alloc: [0] 208 [0] 209 [0] 210 [0] 211 
> [    0.264985] pcpu-alloc: [0] 212 [0] 213 [0] 214 [0] 215 
> [    0.264987] pcpu-alloc: [0] 216 [0] 217 [0] 218 [0] 219 
> [    0.264988] pcpu-alloc: [0] 220 [0] 221 [0] 222 [0] 223 
> [    0.264989] pcpu-alloc: [0] 224 [0] 225 [0] 226 [0] 227 
> [    0.264990] pcpu-alloc: [0] 228 [0] 229 [0] 230 [0] 231 
> [    0.264991] pcpu-alloc: [0] 232 [0] 233 [0] 234 [0] 235 
> [    0.264993] pcpu-alloc: [0] 236 [0] 237 [0] 238 [0] 239 
> [    0.264994] pcpu-alloc: [0] 240 [0] 241 [0] 242 [0] 243 
> [    0.264995] pcpu-alloc: [0] 244 [0] 245 [0] 246 [0] 247 
> [    0.264996] pcpu-alloc: [0] 248 [0] 249 [0] 250 [0] 251 
> [    0.264998] pcpu-alloc: [0] 252 [0] 253 [0] 254 [0] 255 
> [    0.264999] pcpu-alloc: [0] 256 [0] 257 [0] 258 [0] 259 
> [    0.265000] pcpu-alloc: [0] 260 [0] 261 [0] 262 [0] 263 
> [    0.265001] pcpu-alloc: [0] 264 [0] 265 [0] 266 [0] 267 
> [    0.265002] pcpu-alloc: [0] 268 [0] 269 [0] 270 [0] 271 
> [    0.265004] pcpu-alloc: [0] 272 [0] 273 [0] 274 [0] 275 
> [    0.265005] pcpu-alloc: [0] 276 [0] 277 [0] 278 [0] 279 
> [    0.265006] pcpu-alloc: [0] 280 [0] 281 [0] 282 [0] 283 
> [    0.265007] pcpu-alloc: [0] 284 [0] 285 [0] 286 [0] 287 
> [    0.265009] pcpu-alloc: [0] 288 [0] 289 [0] 290 [0] 291 
> [    0.265010] pcpu-alloc: [0] 292 [0] 293 [0] 294 [0] 295 
> [    0.265011] pcpu-alloc: [0] 296 [0] 297 [0] 298 [0] 299 
> [    0.265012] pcpu-alloc: [0] 300 [0] 301 [0] 302 [0] 303 
> [    0.265013] pcpu-alloc: [0] 304 [0] 305 [0] 306 [0] 307 
> [    0.265015] pcpu-alloc: [0] 308 [0] 309 [0] 310 [0] 311 
> [    0.265016] pcpu-alloc: [0] 312 [0] 313 [0] 314 [0] 315 
> [    0.265017] pcpu-alloc: [0] 316 [0] 317 [0] 318 [0] 319 
> [    0.265018] pcpu-alloc: [0] 320 [0] 321 [0] 322 [0] 323 
> [    0.265019] pcpu-alloc: [0] 324 [0] 325 [0] 326 [0] 327 
> [    0.265021] pcpu-alloc: [0] 328 [0] 329 [0] 330 [0] 331 
> [    0.265022] pcpu-alloc: [0] 332 [0] 333 [0] 334 [0] 335 
> [    0.265023] pcpu-alloc: [0] 336 [0] 337 [0] 338 [0] 339 
> [    0.265049] Built 1 zonelists, mobility grouping on.  Total pages: 33030144
> [    0.265050] Policy zone: Normal
> [    0.265051] Kernel command line: root=/dev/disk/by-path/ccw-0.0.3318-part1 rd.dasd=0.0.3318 cio_ignore=all,!condev rd.znet=qeth,0.0.bd00,0.0.bd01,0.0.bd02,layer2=1,portno=0,portname=OSAPORT zfcp.allow_lun_scan=0 BOOT_IMAGE=0 crashkernel=1G dyndbg="module=vhost +plt" BOOT_IMAGE=
> [    0.266109] printk: log_buf_len individual max cpu contribution: 4096 bytes
> [    0.266110] printk: log_buf_len total cpu_extra contributions: 1388544 bytes
> [    0.266111] printk: log_buf_len min size: 131072 bytes
> [    0.266445] printk: log_buf_len: 2097152 bytes
> [    0.266446] printk: early log buf free: 123876(94%)
> [    0.276285] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
> [    0.280904] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
> [    0.280941] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.317267] Memory: 2315096K/134217728K available (10452K kernel code, 2024K rwdata, 3072K rodata, 3932K init, 852K bss, 3355708K reserved, 0K cma-reserved)
> [    0.317724] SLUB: HWalign=256, Order=0-3, MinObjects=0, CPUs=340, Nodes=1
> [    0.317774] ftrace: allocating 31563 entries in 124 pages
> [    0.322372] ftrace: allocated 124 pages with 5 groups
> [    0.323313] rcu: Hierarchical RCU implementation.
> [    0.323313] rcu: 	RCU event tracing is enabled.
> [    0.323314] rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=340.
> [    0.323315] 	Tasks RCU enabled.
> [    0.323316] rcu: RCU calculated value of scheduler-enlistment delay is 11 jiffies.
> [    0.323317] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=340
> [    0.326356] NR_IRQS: 3, nr_irqs: 3, preallocated irqs: 3
> [    0.326494] clocksource: tod: mask: 0xffffffffffffffff max_cycles: 0x3b0a9be803b0a9, max_idle_ns: 1805497147909793 ns
> [    0.326764] Console: colour dummy device 80x25
> [    0.431448] printk: console [ttyS0] enabled
> [    0.526088] Calibrating delay loop (skipped)... 21881.00 BogoMIPS preset
> [    0.526089] pid_max: default: 348160 minimum: 2720
> [    0.526240] LSM: Security Framework initializing
> [    0.526272] SELinux:  Initializing.
> [    0.526529] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    0.526675] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    0.527718] rcu: Hierarchical SRCU implementation.
> [    0.530478] smp: Bringing up secondary CPUs ...
> [    0.544916] smp: Brought up 1 node, 64 CPUs
> [    1.570355] node 0 initialised, 32136731 pages in 1020ms
> [    1.597908] devtmpfs: initialized
> [    1.598796] random: get_random_u32 called from bucket_table_alloc.isra.0+0x82/0x120 with crng_init=0
> [    1.599376] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    1.600153] futex hash table entries: 131072 (order: 13, 33554432 bytes, vmalloc)
> [    1.604749] xor: automatically using best checksumming function   xc        
> [    1.604926] NET: Registered protocol family 16
> [    1.604962] audit: initializing netlink subsys (disabled)
> [    1.605034] audit: type=2000 audit(1583350720.705:1): state=initialized audit_enabled=0 res=1
> [    1.605170] Spectre V2 mitigation: etokens
> [    1.605877] random: fast init done
> [    1.612650] HugeTLB registered 1.00 MiB page size, pre-allocated 0 pages
> [    1.866553] raid6: vx128x8  gen() 21598 MB/s
> [    2.036503] raid6: vx128x8  xor() 13323 MB/s
> [    2.036505] raid6: using algorithm vx128x8 gen() 21598 MB/s
> [    2.036505] raid6: .... xor() 13323 MB/s, rmw enabled
> [    2.036506] raid6: using s390xc recovery algorithm
> [    2.036881] iommu: Default domain type: Translated 
> [    2.037025] SCSI subsystem initialized
> [    2.100086] PCI host bridge to bus 0000:00
> [    2.100093] pci_bus 0000:00: root bus resource [mem 0x8000000000000000-0x8000000007ffffff 64bit pref]
> [    2.100096] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
> [    2.100170] pci 0000:00:00.0: [1014:044b] type 00 class 0x120000
> [    2.100231] pci 0000:00:00.0: reg 0x10: [mem 0xffffd80008000000-0xffffd8000fffffff 64bit pref]
> [    2.100547] pci 0000:00:00.0: 0.000 Gb/s available PCIe bandwidth, limited by Unknown speed x0 link at 0000:00:00.0 (capable of 32.000 Gb/s with 5 GT/s x8 link)
> [    2.100590] pci 0000:00:00.0: Adding to iommu group 0
> [    2.100601] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
> [    2.102924] PCI host bridge to bus 0001:00
> [    2.102926] pci_bus 0001:00: root bus resource [mem 0x8001000000000000-0x80010000000fffff 64bit pref]
> [    2.102929] pci_bus 0001:00: No busn resource found for root bus, will use [bus 00-ff]
> [    2.103023] pci 0001:00:00.0: [15b3:1016] type 00 class 0x020000
> [    2.103129] pci 0001:00:00.0: reg 0x10: [mem 0xffffd40002000000-0xffffd400020fffff 64bit pref]
> [    2.103289] pci 0001:00:00.0: enabling Extended Tags
> [    2.103793] pci 0001:00:00.0: 0.000 Gb/s available PCIe bandwidth, limited by Unknown speed x0 link at 0001:00:00.0 (capable of 63.008 Gb/s with 8 GT/s x8 link)
> [    2.103831] pci 0001:00:00.0: Adding to iommu group 1
> [    2.103840] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to 00
> [    2.106095] PCI host bridge to bus 0002:00
> [    2.106097] pci_bus 0002:00: root bus resource [mem 0x8002000000000000-0x80020000000fffff 64bit pref]
> [    2.106099] pci_bus 0002:00: No busn resource found for root bus, will use [bus 00-ff]
> [    2.106184] pci 0002:00:00.0: [15b3:1016] type 00 class 0x020000
> [    2.106284] pci 0002:00:00.0: reg 0x10: [mem 0xffffd40008000000-0xffffd400080fffff 64bit pref]
> [    2.106439] pci 0002:00:00.0: enabling Extended Tags
> [    2.107033] pci 0002:00:00.0: 0.000 Gb/s available PCIe bandwidth, limited by Unknown speed x0 link at 0002:00:00.0 (capable of 63.008 Gb/s with 8 GT/s x8 link)
> [    2.107068] pci 0002:00:00.0: Adding to iommu group 2
> [    2.107074] pci_bus 0002:00: busn_res: [bus 00-ff] end is updated to 00
> [    2.669299] VFS: Disk quotas dquot_6.6.0
> [    2.669354] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    2.670694] random: crng init done
> [    2.671085] NET: Registered protocol family 2
> [    2.671733] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> [    2.672293] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc)
> [    2.674302] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> [    2.674808] TCP: Hash tables configured (established 524288 bind 65536)
> [    2.675133] UDP hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
> [    2.676140] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
> [    2.677625] NET: Registered protocol family 1
> [    2.677828] Trying to unpack rootfs image as initramfs...
> [    3.248308] Freeing initrd memory: 43596K
> [    3.249509] alg: No test for crc32be (crc32be-vx)
> [    3.253769] Initialise system trusted keyrings
> [    3.253823] workingset: timestamp_bits=45 max_order=25 bucket_order=0
> [    3.254971] fuse: init (API version 7.31)
> [    3.255041] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
> [    3.261726] Key type asymmetric registered
> [    3.261728] Asymmetric key parser 'x509' registered
> [    3.261733] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
> [    3.261934] io scheduler mq-deadline registered
> [    3.261936] io scheduler kyber registered
> [    3.261957] io scheduler bfq registered
> [    3.262765] atomic64_test: passed
> [    3.262816] hvc_iucv: The z/VM IUCV HVC device driver cannot be used without z/VM
> [    3.269334] brd: module loaded
> [    3.269693] cio: Channel measurement facility initialized using format extended (mode autodetected)
> [    3.269968] Discipline DIAG cannot be used without z/VM
> [    5.124916] sclp_sd: No data is available for the config data entity
> [    5.341297] qeth: loading core functions
> [    5.341358] qeth: register layer 2 discipline
> [    5.341360] qeth: register layer 3 discipline
> [    5.341883] NET: Registered protocol family 10
> [    5.342820] Segment Routing with IPv6
> [    5.342835] NET: Registered protocol family 17
> [    5.342845] Key type dns_resolver registered
> [    5.342935] registered taskstats version 1
> [    5.342940] Loading compiled-in X.509 certificates
> [    5.382486] Loaded X.509 cert 'Build time autogenerated kernel key: c46ba92ee388c82c5891ee836c9c20b752cdfac5'
> [    5.383144] zswap: default zpool zbud not available
> [    5.383145] zswap: pool creation failed
> [    5.383866] Key type ._fscrypt registered
> [    5.383867] Key type .fscrypt registered
> [    5.383868] Key type fscrypt-provisioning registered
> [    5.384137] Btrfs loaded, crc32c=crc32c-vx
> [    5.388723] Key type big_key registered
> [    5.388729] ima: No TPM chip found, activating TPM-bypass!
> [    5.388732] ima: Allocated hash algorithm: sha256
> [    5.388740] ima: No architecture policies found
> [    5.389834] Freeing unused kernel memory: 3932K
> [    5.446574] Write protected read-only-after-init data: 68k
> [    5.446577] Run /init as init process
> [    5.446577]   with arguments:
> [    5.446578]     /init
> [    5.446578]   with environment:
> [    5.446578]     HOME=/
> [    5.446578]     TERM=linux
> [    5.446578]     BOOT_IMAGE=
> [    5.446579]     crashkernel=1G
> [    5.446579]     dyndbg=module=vhost +plt
> [    5.461019] systemd[1]: Inserted module 'autofs4'
> [    5.462181] systemd[1]: systemd v243.7-1.fc31 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=unified)
> [    5.462869] systemd[1]: Detected architecture s390x.
> [    5.462871] systemd[1]: Running in initial RAM disk.
> [    5.462923] systemd[1]: Set hostname to <m83lp52.lnxne.boe>.
> [    5.503062] systemd[1]: Reached target Local File Systems.
> [    5.503120] systemd[1]: Reached target Slices.
> [    5.503143] systemd[1]: Reached target Swap.
> [    5.503160] systemd[1]: Reached target Timers.
> [    5.503254] systemd[1]: Listening on Journal Audit Socket.
> [    5.503305] systemd[1]: Listening on Journal Socket (/dev/log).
> [    5.782907] audit: type=1130 audit(1583350724.885:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    5.792394] audit: type=1130 audit(1583350724.895:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    6.869558] audit: type=1130 audit(1583350725.975:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    6.885592] audit: type=1130 audit(1583350725.985:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    6.886066] audit: type=1334 audit(1583350725.985:6): prog-id=6 op=LOAD
> [    6.886093] audit: type=1334 audit(1583350725.985:7): prog-id=7 op=LOAD
> [    7.106613] audit: type=1130 audit(1583350726.215:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    7.110846] qeth 0.0.bd00: Priority Queueing not supported
> [    7.111597] qeth 0.0.bd00: portname is deprecated and is ignored
> [    7.112828] dasd-eckd 0.0.3318: A channel path to the device has become operational
> [    7.112971] dasd-eckd 0.0.3319: A channel path to the device has become operational
> [    7.113686] dasd-eckd 0.0.331a: A channel path to the device has become operational
> [    7.113910] dasd-eckd 0.0.331b: A channel path to the device has become operational
> [    7.117112] qdio: 0.0.bd02 OSA on SC 159b using AI:1 QEBSM:0 PRI:1 TDD:1 SIGA: W AP
> [    7.123509] dasd-eckd 0.0.3319: New DASD 3390/0E (CU 3990/01) with 262668 cylinders, 15 heads, 224 sectors
> [    7.126422] dasd-eckd 0.0.3319: DASD with 4 KB/block, 189120960 KB total size, 48 KB/track, compatible disk layout
> [    7.127590]  dasdb:VOL1/  0X3319: dasdb1
> [    7.128367] dasd-eckd 0.0.3318: New DASD 3390/0E (CU 3990/01) with 262668 cylinders, 15 heads, 224 sectors
> [    7.130987] dasd-eckd 0.0.3318: DASD with 4 KB/block, 189120960 KB total size, 48 KB/track, compatible disk layout
> [    7.132054]  dasda:VOL1/  0X3318: dasda1
> [    7.133315] dasd-eckd 0.0.331a: New DASD 3390/0C (CU 3990/01) with 30051 cylinders, 15 heads, 224 sectors
> [    7.136326] dasd-eckd 0.0.331a: DASD with 4 KB/block, 21636720 KB total size, 48 KB/track, compatible disk layout
> [    7.137145]  dasdc:VOL1/  0X331A:
> [    7.138060] dasd-eckd 0.0.331b: New DASD 3390/0C (CU 3990/01) with 30051 cylinders, 15 heads, 224 sectors
> [    7.140842] dasd-eckd 0.0.331b: DASD with 4 KB/block, 21636720 KB total size, 48 KB/track, compatible disk layout
> [    7.141538]  dasdd:VOL1/  0X331B:
> [    7.147527] audit: type=1130 audit(1583350726.255:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    7.149679] qeth 0.0.bd00: QDIO data connection isolation is deactivated
> [    7.150155] qeth 0.0.bd00: The device represents a Bridge Capable Port
> [    7.153543] qeth 0.0.bd00: MAC address 8e:dc:f9:1b:1d:48 successfully registered
> [    7.154070] qeth 0.0.bd00: Device is a OSD Express card (level: 0199)
>                with link type OSD_10GIG.
> [    7.163550] audit: type=1130 audit(1583350726.265:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=plymouth-start comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    7.189372] qeth 0.0.bd00: MAC address de:45:d7:61:c4:13 successfully registered
> [    7.191686] qeth 0.0.bd00 encbd00: renamed from eth0
> [    7.380543] mlx5_core 0001:00:00.0: enabling device (0000 -> 0002)
> [    7.380634] mlx5_core 0001:00:00.0: firmware version: 14.23.1020
> [    7.464556] dasdconf.sh Warning: 0.0.3318 is already online, not configuring
> [    7.513188] dasdconf.sh Warning: 0.0.331b is already online, not configuring
> [    7.513319] dasdconf.sh Warning: 0.0.331a is already online, not configuring
> [    7.524280] dasdconf.sh Warning: 0.0.3319 is already online, not configuring
> [    7.822902] mlx5_core 0002:00:00.0: enabling device (0000 -> 0002)
> [    7.822988] mlx5_core 0002:00:00.0: firmware version: 14.23.1020
> [    8.272590] mlx5_core 0001:00:00.0: MLX5E: StrdRq(0) RqSz(1024) StrdSz(256) RxCqeCmprss(0)
> [    8.411681] mlx5_core 0002:00:00.0: MLX5E: StrdRq(0) RqSz(1024) StrdSz(256) RxCqeCmprss(0)
> [    8.573287] mlx5_core 0001:00:00.0 enP1s519: renamed from eth0
> [    8.827283] mlx5_core 0002:00:00.0 enP2s564: renamed from eth1
> [    9.027834] audit: type=1130 audit(1583350728.135:11): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    9.045379] audit: type=1130 audit(1583350728.145:12): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-fsck-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    9.054299] EXT4-fs (dasda1): mounted filesystem with ordered data mode. Opts: (null)
> [    9.063290] audit: type=1334 audit(1583350728.165:13): prog-id=7 op=UNLOAD
> [    9.380815] systemd-journald[543]: Received SIGTERM from PID 1 (systemd).
> [    9.395001] printk: systemd: 19 output lines suppressed due to ratelimiting
> [    9.661651] SELinux:  Permission watch in class filesystem not defined in policy.
> [    9.661656] SELinux:  Permission watch in class file not defined in policy.
> [    9.661657] SELinux:  Permission watch_mount in class file not defined in policy.
> [    9.661658] SELinux:  Permission watch_sb in class file not defined in policy.
> [    9.661659] SELinux:  Permission watch_with_perm in class file not defined in policy.
> [    9.661660] SELinux:  Permission watch_reads in class file not defined in policy.
> [    9.661662] SELinux:  Permission watch in class dir not defined in policy.
> [    9.661663] SELinux:  Permission watch_mount in class dir not defined in policy.
> [    9.661664] SELinux:  Permission watch_sb in class dir not defined in policy.
> [    9.661665] SELinux:  Permission watch_with_perm in class dir not defined in policy.
> [    9.661666] SELinux:  Permission watch_reads in class dir not defined in policy.
> [    9.661670] SELinux:  Permission watch in class lnk_file not defined in policy.
> [    9.661670] SELinux:  Permission watch_mount in class lnk_file not defined in policy.
> [    9.661672] SELinux:  Permission watch_sb in class lnk_file not defined in policy.
> [    9.661673] SELinux:  Permission watch_with_perm in class lnk_file not defined in policy.
> [    9.661674] SELinux:  Permission watch_reads in class lnk_file not defined in policy.
> [    9.661676] SELinux:  Permission watch in class chr_file not defined in policy.
> [    9.661690] SELinux:  Permission watch_mount in class chr_file not defined in policy.
> [    9.661691] SELinux:  Permission watch_sb in class chr_file not defined in policy.
> [    9.661692] SELinux:  Permission watch_with_perm in class chr_file not defined in policy.
> [    9.661693] SELinux:  Permission watch_reads in class chr_file not defined in policy.
> [    9.661695] SELinux:  Permission watch in class blk_file not defined in policy.
> [    9.661696] SELinux:  Permission watch_mount in class blk_file not defined in policy.
> [    9.661697] SELinux:  Permission watch_sb in class blk_file not defined in policy.
> [    9.661698] SELinux:  Permission watch_with_perm in class blk_file not defined in policy.
> [    9.661699] SELinux:  Permission watch_reads in class blk_file not defined in policy.
> [    9.661702] SELinux:  Permission watch in class sock_file not defined in policy.
> [    9.661702] SELinux:  Permission watch_mount in class sock_file not defined in policy.
> [    9.661704] SELinux:  Permission watch_sb in class sock_file not defined in policy.
> [    9.661705] SELinux:  Permission watch_with_perm in class sock_file not defined in policy.
> [    9.661706] SELinux:  Permission watch_reads in class sock_file not defined in policy.
> [    9.661708] SELinux:  Permission watch in class fifo_file not defined in policy.
> [    9.661710] SELinux:  Permission watch_mount in class fifo_file not defined in policy.
> [    9.661710] SELinux:  Permission watch_sb in class fifo_file not defined in policy.
> [    9.661711] SELinux:  Permission watch_with_perm in class fifo_file not defined in policy.
> [    9.661712] SELinux:  Permission watch_reads in class fifo_file not defined in policy.
> [    9.661793] SELinux:  Class perf_event not defined in policy.
> [    9.661794] SELinux:  Class lockdown not defined in policy.
> [    9.661795] SELinux: the above unknown classes and permissions will be allowed
> [    9.661808] SELinux:  policy capability network_peer_controls=1
> [    9.661809] SELinux:  policy capability open_perms=1
> [    9.661810] SELinux:  policy capability extended_socket_class=1
> [    9.661811] SELinux:  policy capability always_check_network=0
> [    9.661811] SELinux:  policy capability cgroup_seclabel=1
> [    9.661812] SELinux:  policy capability nnp_nosuid_transition=1
> [    9.741220] systemd[1]: Successfully loaded SELinux policy in 291.310ms.
> [    9.789736] systemd[1]: Relabelled /dev, /dev/shm, /run, /sys/fs/cgroup in 12.825ms.
> [    9.791767] systemd[1]: systemd v243.7-1.fc31 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=unified)
> [    9.792457] systemd[1]: Detected architecture s390x.
> [    9.793656] systemd[1]: Set hostname to <m83lp52.lnxne.boe>.
> [    9.902467] systemd[1]: /usr/lib/systemd/system/sssd.service:12: PIDFile= references a path below legacy directory /var/run/, updating /var/run/sssd.pid → /run/sssd.pid; please update the unit file accordingly.
> [    9.906424] systemd[1]: /usr/lib/systemd/system/iscsid.service:11: PIDFile= references a path below legacy directory /var/run/, updating /var/run/iscsid.pid → /run/iscsid.pid; please update the unit file accordingly.
> [    9.906622] systemd[1]: /usr/lib/systemd/system/iscsiuio.service:13: PIDFile= references a path below legacy directory /var/run/, updating /var/run/iscsiuio.pid → /run/iscsiuio.pid; please update the unit file accordingly.
> [    9.934051] systemd[1]: /usr/lib/systemd/system/sssd-kcm.socket:7: ListenStream= references a path below legacy directory /var/run/, updating /var/run/.heim_org.h5l.kcm-socket → /run/.heim_org.h5l.kcm-socket; please update the unit file accordingly.
> [    9.961533] systemd[1]: initrd-switch-root.service: Succeeded.
> [    9.961634] systemd[1]: Stopped Switch Root.
> [    9.961890] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
> [    9.989554] EXT4-fs (dasda1): re-mounted. Opts: (null)
> [   10.299160] systemd-journald[1085]: Received client request to flush runtime journal.
> [   10.499707] VFIO - User Level meta-driver version: 0.3
> [   10.530145] genwqe 0000:00:00.0: enabling device (0000 -> 0002)
> [   10.532037] dasdconf.sh Warning: 0.0.331a is already online, not configuring
> [   10.534362] dasdconf.sh Warning: 0.0.331b is already online, not configuring
> [   10.534490] dasdconf.sh Warning: 0.0.3319 is already online, not configuring
> [   10.534516] dasdconf.sh Warning: 0.0.3318 is already online, not configuring
> [   10.768265] mlx5_ib: Mellanox Connect-IB Infiniband driver v5.0-0
> [   10.954777] XFS (dasdb1): Mounting V5 Filesystem
> [   10.967218] RPC: Registered named UNIX socket transport module.
> [   10.967221] RPC: Registered udp transport module.
> [   10.967223] RPC: Registered tcp transport module.
> [   10.967224] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [   10.985393] XFS (dasdb1): Ending clean mount
> [   10.987810] xfs filesystem being mounted at /home supports timestamps until 2038 (0x7fffffff)
> [   11.002317] RPC: Registered rdma transport module.
> [   11.002319] RPC: Registered rdma backchannel transport module.
> [   11.943320] mlx5_core 0001:00:00.0 enP1s519: Link up
> [   11.945973] IPv6: ADDRCONF(NETDEV_CHANGE): enP1s519: link becomes ready
> [   12.063453] mlx5_core 0002:00:00.0 enP2s564: Link up
> [   12.136089] tun: Universal TUN/TAP device driver, 1.6
> [   12.137058] virbr0: port 1(virbr0-nic) entered blocking state
> [   12.137060] virbr0: port 1(virbr0-nic) entered disabled state
> [   12.137150] device virbr0-nic entered promiscuous mode
> [   12.536173] virbr0: port 1(virbr0-nic) entered blocking state
> [   12.536176] virbr0: port 1(virbr0-nic) entered listening state
> [   12.560143] virbr0: port 1(virbr0-nic) entered disabled state
> [   12.976588] IPv6: ADDRCONF(NETDEV_CHANGE): enP2s564: link becomes ready
> [   25.680326] CPU62 path=/machine.slice/machine-test.slice/machine-qemu\x2d16\x2dtest14. on_list=1 nr_running=1 p=[CPU 1/KVM 2543]
> [   25.680334] ------------[ cut here ]------------
> [   25.680335] rq->tmp_alone_branch != &rq->leaf_cfs_rq_list
> [   25.680351] WARNING: CPU: 61 PID: 2535 at kernel/sched/fair.c:380 enqueue_task_fair+0x3f6/0x4a8
> [   25.680353] Modules linked in: kvm xt_CHECKSUM xt_MASQUERADE nf_nat_tftp nf_conntrack_tftp xt_CT tun bridge stp llc xt_tcpudp ip6t_REJECT nf_reject_ipv6 ip6t_rpfilter ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ip6table_filter ip6_tables iptable_filter rpcrdma sunrpc rdma_ucm rdma_cm iw_cm ib_cm configfs mlx5_ib s390_trng ghash_s390 prng aes_s390 ib_uverbs des_s390 libdes sha3_512_s390 ib_core sha3_256_s390 sha512_s390 sha1_s390 genwqe_card vfio_ccw crc_itu_t vfio_mdev mdev vfio_iommu_type1 vfio eadm_sch zcrypt_cex4 sch_fq_codel ip_tables x_tables mlx5_core sha256_s390 sha_common pkey zcrypt rng_core autofs4
> [   25.680397] CPU: 61 PID: 2535 Comm: CPU 0/KVM Not tainted 5.6.0-rc3+ #159
> [   25.680398] Hardware name: IBM 3906 M04 704 (LPAR)
> [   25.680399] Krnl PSW : 0404c00180000000 0000001b0ed9ef0a (enqueue_task_fair+0x3fa/0x4a8)
> [   25.680402]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [   25.680404] Krnl GPRS: 00000000000003e0 0000001e40060400 000000000000002d 0000001b100507c2
> [   25.680405]            000000000000002c 0000001b0f4089d0 0000000000000001 0400001b00000000
> [   25.680407]            0000001eb757e000 000003e00167bb58 0000001e40060400 0000001fbd840928
> [   25.680454]            0000001ebfc0a000 0000001fbd83fd00 0000001b0ed9ef06 000003e00167baa0
> [   25.680461] Krnl Code: 0000001b0ed9eefa: c020005d398a	larl	%r2,0000001b0f94620e
>                           0000001b0ed9ef00: c0e5fffdcbd8	brasl	%r14,0000001b0ed586b0
>                          #0000001b0ed9ef06: af000000		mc	0,0
>                          >0000001b0ed9ef0a: a7f4febe		brc	15,0000001b0ed9ec86
>                           0000001b0ed9ef0e: ec2cfe68017f	clij	%r2,1,12,0000001b0ed9ebde
>                           0000001b0ed9ef14: e310dd200004	lg	%r1,3360(%r13)
>                           0000001b0ed9ef1a: 58201098		l	%r2,152(%r1)
>                           0000001b0ed9ef1e: ec26fe63007e	cij	%r2,0,6,0000001b0ed9ebe4
> [   25.680475] Call Trace:
> [   25.680477]  [<0000001b0ed9ef0a>] enqueue_task_fair+0x3fa/0x4a8 
> [   25.680479] ([<0000001b0ed9ef06>] enqueue_task_fair+0x3f6/0x4a8)
> [   25.680482]  [<0000001b0ed8ed78>] activate_task+0x88/0xf0 
> [   25.680483]  [<0000001b0ed8f2e8>] ttwu_do_activate+0x58/0x78 
> [   25.680485]  [<0000001b0ed902ce>] try_to_wake_up+0x256/0x650 
> [   25.680489]  [<0000001b0edae50e>] swake_up_locked.part.0+0x2e/0x70 
> [   25.680490]  [<0000001b0edae82c>] swake_up_one+0x54/0x88 
> [   25.680536]  [<000003ff8042315a>] kvm_vcpu_wake_up+0x52/0x78 [kvm] 
> [   25.680545]  [<000003ff80441f0a>] kvm_s390_vcpu_wakeup+0x2a/0x40 [kvm] 
> [   25.680554]  [<000003ff80442696>] kvm_s390_idle_wakeup+0x6e/0xa0 [kvm] 
> [   25.680559]  [<0000001b0edf90dc>] __hrtimer_run_queues+0x114/0x2f0 
> [   25.680562]  [<0000001b0edf9e34>] hrtimer_interrupt+0x12c/0x2a8 
> [   25.680564]  [<0000001b0ed1cd3c>] do_IRQ+0xac/0xb0 
> [   25.680570]  [<0000001b0f741704>] ext_int_handler+0x130/0x134 
> [   25.680572]  [<0000001b0f740dc6>] sie_exit+0x0/0x46 
> [   25.680580] ([<000003ff8043a452>] __vcpu_run+0x3a2/0xcb0 [kvm])
> [   25.680589]  [<000003ff8043b7c0>] kvm_arch_vcpu_ioctl_run+0x248/0x880 [kvm] 
> [   25.680597]  [<000003ff804261d4>] kvm_vcpu_ioctl+0x284/0x7b0 [kvm] 
> [   25.680602]  [<0000001b0efdac0e>] ksys_ioctl+0xae/0xe8 
> [   25.680604]  [<0000001b0efdacb2>] __s390x_sys_ioctl+0x2a/0x38 
> [   25.680605]  [<0000001b0f7410b2>] system_call+0x2a6/0x2c8 
> [   25.680606] Last Breaking-Event-Address:
> [   25.680609]  [<0000001b0ed58710>] __warn_printk+0x60/0x68
> [   25.680610] ---[ end trace 1298e6d8f1f0ce77 ]---


