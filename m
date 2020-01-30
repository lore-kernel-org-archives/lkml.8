Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B078C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 07:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADE4206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 07:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fp1c8UWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgA3HbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 02:31:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36984 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgA3HbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 02:31:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so1196539pga.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 23:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ADHXjKY+wZDM9guKVG7zd0Mm0y/rFvUhm90KVH/W/To=;
        b=Fp1c8UWqKSduatMedNJg0JXB/cDi6eI2Wrbfrp6MJ5KJRNA0LWiRIaqH76kSGfRNXA
         jmHuaJCmIhoo2Ke+TactuJKRkD5y0q1dMAC1GAx17HOz7T1HFXlFTBeH88btIzU1UZ8B
         Xy7mH3LMmlaNF+2H8DfVx4Tj3WSs99RPke1B/lyDIW1JSQ/SrKlvBDN38QWmUFU2Ece9
         Gm0x0tIjIMRFQXPI3kJwgdYnoyTnpRh7O3HiQExPmOLecfwBBSy1sTPJb8NCkH/XwSsT
         XRSXFYdLPZ+nVEc43gAJQx58khG781NfrLBfs0rq0fxDNzK0ZJsGRMnhGpFwg3aH9Qls
         AA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ADHXjKY+wZDM9guKVG7zd0Mm0y/rFvUhm90KVH/W/To=;
        b=I8xJEXaBJ02WER+3XkNPsHyMIjjZOS9fcOH+W974Li+y/IBo6XD/JKuIGflwLMBrJJ
         EZZjrA9T179DySsj4n12ldfWoZ8wZcuj/pO6hnxPvDew8YZA+k2wj3g+GkVXeFUJjLs9
         RwNrGRRsP48mjxYVbWYlJaGtCPqdTL7xUdPqKrfamMb1Dc5E6oF+vFZHwa6512a3jlbh
         T8nDmS7DCKGMg6diPPPzhLB5nWWprPjVwrxVaHRJtL1tO64URtPZvTMV2mMtVmwgybFJ
         ZvG/qWqYiYCLDopxXoC13/08i1K0ev7um4qvo64RRe7q/FAsCtvF1ADm5zzX+aTSkZR7
         QBkw==
X-Gm-Message-State: APjAAAX0xhItLcvc3wLETx/EOgKj3VhiHRMi81Tvo/3o1OZRq25n7Ivi
        euHKh5BI7D2yjLTGLMAK7KM=
X-Google-Smtp-Source: APXvYqxjoJ9Bt62qy3k/p7zxSkSmzSaWakYmKUL1JcNAS98p04iHIga/jET0K3QPiSkPdlsLy/6VaA==
X-Received: by 2002:a63:30c:: with SMTP id 12mr3264019pgd.276.1580369479261;
        Wed, 29 Jan 2020 23:31:19 -0800 (PST)
Received: from [192.168.1.101] (122-58-182-19-adsl.sparkbb.co.nz. [122.58.182.19])
        by smtp.gmail.com with ESMTPSA id v7sm5102910pfn.61.2020.01.29.23.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 23:31:18 -0800 (PST)
Subject: Re: [PATCH 0/5] Rewrite Motorola MMU page-table layout
To:     Peter Zijlstra <peterz@infradead.org>
References: <20200129103941.304769381@infradead.org>
 <bbdb9596-583e-5d26-ac1c-4775440059b9@physik.fu-berlin.de>
 <20200129115412.GN14914@hirez.programming.kicks-ass.net>
 <CAOmrzkJ8dsuSnomcE7uhyY9ip6T9ADLT7LhjydvY-hizpikBiA@mail.gmail.com>
 <20200129193109.GS14914@hirez.programming.kicks-ass.net>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <b72358cc-ddd2-52d6-7eed-c88bab46e6f1@gmail.com>
Date:   Thu, 30 Jan 2020 20:31:13 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200129193109.GS14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

Am 30.01.2020 um 08:31 schrieb Peter Zijlstra:
> On Thu, Jan 30, 2020 at 07:52:11AM +1300, Michael Schmitz wrote:
>> Peter,
>>
>> On Thu, Jan 30, 2020 at 12:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Wed, Jan 29, 2020 at 11:49:13AM +0100, John Paul Adrian Glaubitz wrote:
>>>
>>>>> [1] https://wiki.debian.org/M68k/QemuSystemM68k
>>>
>>> Now, if only debian would actually ship that :/
>>>
>>> AFAICT that emulates a q800 which is another 68040 and should thus not
>>> differ from ARAnyM.
>>>
>>> I'm fairly confident in the 040 bits, it's the 020/030 things that need
>>> coverage.
>>
>> I'll take a look - unless this eats up way more kernel memory for page
>> tables, it should still boot on my Falcon.
>
> It should actually be better in most cases I think, since we no longer
> require all 16 pte-tables to map consecutive (virtual) memory.

Not much difference:

              total       used       free     shared    buffers     cached
Mem:         10712      10120        592          0       1860       2276
-/+ buffers/cache:       5984       4728
Swap:      2097144       1552    2095592


vs. vanilla 5.5rc5:
              total       used       free     shared    buffers     cached
Mem:         10716      10104        612          0       1588       2544
-/+ buffers/cache:       5972       4744
Swap:      2097144       1296    2095848

By sheer coincidence, the boot with your patch series happened to run a 
full filesystem check on the root filesystem, so I'd say it got a good 
workout re: paging and swapping (even though it's just a paltry 4 GB).

Haven't tried any VM stress testing yet (not sure what to do for that; 
it's been years since I tried that sort of stuff).

Cheers,

	Michael


