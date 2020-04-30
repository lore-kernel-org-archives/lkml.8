Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE980C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89CFA20731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI0twVI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgD3P1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbgD3P1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:27:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA30C035494;
        Thu, 30 Apr 2020 08:27:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fu13so834721pjb.5;
        Thu, 30 Apr 2020 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h7aecSn7WemaPr5MKAU25qlIzkvX9/7QdX+8sxse6As=;
        b=RI0twVI0BCbvsJGtmfAURnVd29jYqM/+tPwkK6KWFVPzAsJUtQO+isXMTV5bxrTixq
         IEi4hZENsklYeP6tC5frsru0LnToqen1Mmu5G25ZTukvm1eQ5E9sTcECsNVSRSTHjfs6
         OSelV67AYFF2IG4iYEyGFbMbRLlp18AgzPfij6hW3M92CTGsTFmkc5N1QMlvHTI65qKD
         1IIDHIHH2XT0eDme/InswnMbTsndIVcx/qXa9HZk4kTuMKIrNCbYf4L/5IWqv+5TU+4j
         xzEhFuekRqi2jKQCgBcIJ6hJeeXDuS+VJtgQGlTu2QURv9p3fS2qKv2tNa8g1zjvQAeG
         g8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h7aecSn7WemaPr5MKAU25qlIzkvX9/7QdX+8sxse6As=;
        b=rkVN9gy526efa75nYVZy91YuRnV3g+/PiJGH6CDxM1ZEtDCg/gOoiSA1UAG5wtGcX+
         928IrwtYiVLSDXTRCnvAn758Fz9gzvW08o9orZh1d5sXm8MAszGUOzZ4tsBThEPDIRUr
         YH0M6CKxbFvfOH9nmo42qs1veTK0JTTY79ccJ6//b/KNSYjgm3ivSAck8T4chFy8fjj0
         50Jlcw1Nt+cTNpEqRamjNKlFWaOovy1FjAxzJ6NrcH/os6o33O3xpocIOUHQ22yCmqcV
         CMc7FMCD3CYchR/CXfIVE8avqkupM6cWOXIqSqKwFLv/sbz0CTfH2yS84Huz55gO6jDM
         IL5A==
X-Gm-Message-State: AGi0PuY2NzzGgJM5XQlvc3TMst813yWfR2urIp93qP5mg+uEZM2rz5bG
        +gxs2zzSacLfVSO8H9f8Rsly4Vy48Fg=
X-Google-Smtp-Source: APiQypIhxBzQQ6uCPbobz43ZrYPYjT701oHyGyUly2zIMwKfqwCDzxsjhwA6Wk4frpoXp791ofbnHA==
X-Received: by 2002:a17:902:d70f:: with SMTP id w15mr4420618ply.55.1588260469297;
        Thu, 30 Apr 2020 08:27:49 -0700 (PDT)
Received: from [192.168.1.159] (ip70-185-146-31.sb.sd.cox.net. [70.185.146.31])
        by smtp.gmail.com with ESMTPSA id q64sm150019pfc.112.2020.04.30.08.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 08:27:48 -0700 (PDT)
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at
 00000000000000a8 in nilfs_segctor_do_co
To:     Hideki EIRAKU <hdk1983@gmail.com>, linux-nilfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200328.182640.1933740379722138264.hermes@ceres.dti.ne.jp>
 <20200430.213842.00392641.hdk1983@gmail.com>
From:   Tom <tommytoad0@gmail.com>
Message-ID: <ee5677b7-802b-f524-36cc-9d5ae071859b@gmail.com>
Date:   Thu, 30 Apr 2020 08:27:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430.213842.00392641.hdk1983@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you!  This is very helpful information, and does seem to be a 
workaround.

Like you, I have my home directory on a separate NILFS2 filesystem. As a 
temporary solution, I removed the line from /etc/fstab for that 
filesystem and added your dd suggestion along with a manual mount of the 
home filesystem to /etc/rc.local.  /home is now mounted properly at boot 
with any of the newer kernels I tried.

Thanks,
Tom

On 4/30/20 5:38 AM, Hideki EIRAKU wrote:
>> In Msg <874kuapb2s.fsf@logand.com>;
>>     Subject "Re: BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8 in nilfs_segctor_do_construct":
>>
>>> Tomas Hlavaty <tom@logand.com> writes:
>>>>>> 2) Can you mount the corrupted(?) partition from a recent version of
>>>>>> kernel ?
>>>
>>> I tried the following Linux kernel versions:
>>>
>>> - v4.19
>>> - v5.4
>>> - v5.5.11
>>>
>>> and still get the crash
> 
> I found conditions to reproduce this issue with Linux 5.7-rc3:
> 
> - CONFIG_MEMCG=y *and* CONFIG_BLK_CGROUP=y
> 
> - When the NILFS2 file system writes to a device, the device file has
>    never written by other programs since boot
> 
> The following is an example with CONFIG_MEMCG=y and
> CONFIG_BLK_CGROUP=y kernel.  If you do mkfs and mount it, it works
> because the mkfs command has written data to the device file before
> mounting:
> 
> # mkfs -t nilfs2 /dev/sda1
> mkfs.nilfs2 (nilfs-utils 2.2.7)
> Start writing file system initial data to the device
>         Blocksize:4096  Device:/dev/sda1  Device Size:267386880
> File system initialization succeeded !!
> # mount /dev/sda1 /mnt
> # touch /mnt
> # sync
> #
> 
> Loopback mount seems to be the same - if you do losetup, mkfs and
> mount on a loopback device, it works:
> 
> # losetup /dev/loop0 foo
> # mkfs -t nilfs2 /dev/loop0
> mkfs.nilfs2 (nilfs-utils 2.2.7)
> Start writing file system initial data to the device
>         Blocksize:4096  Device:/dev/loop0  Device Size:267386880
> File system initialization succeeded !!
> # mount /dev/sda1 /mnt
> # touch /mnt
> # sync
> #
> 
> But if you do mkfs on a file and use mount -o loop, it may fail,
> depending on whether the loopback device assigned by the mount command
> was used or not before mounting:
> 
> # /sbin/mkfs.nilfs2 ./foo
> mkfs.nilfs2 (nilfs-utils 2.2.7)
> Start writing file system initial data to the device
>         Blocksize:4096  Device:./foo  Device Size:268435456
> File system initialization succeeded !!
> # mount -o loop ./foo /mnt
> [   36.371331] NILFS (loop0): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
> # touch /mnt
> # sync
> [   40.252869] BUG: kernel NULL pointer dereference, address: 00000000000000a8
> (snip)
> 
> After reboot, it fails:
> 
> # mount /dev/sda1 /mnt
> [   14.021188] NILFS (sda1): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
> # touch /mnt
> # sync
> [   20.576309] BUG: kernel NULL pointer dereference, address: 00000000000000a8
> (snip)
> 
> But if you do dummy write to the device file before mounting, it
> works:
> 
> # dd if=/dev/sda1 of=/dev/sda1 count=1
> 1+0 records in
> 1+0 records out
> 512 bytes copied, 0.0135982 s, 37.7 kB/s
> # mount /dev/sda1 /mnt
> [   52.604560] NILFS (sda1): mounting unchecked fs
> [   52.613335] NILFS (sda1): recovery complete
> [   52.613877] NILFS (sda1): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
> # touch /mnt
> # sync
> #
> 
> # losetup /dev/loop0 foo
> # dd if=/dev/loop0 of=/dev/loop0 count=1
> 1+0 records in
> 1+0 records out
> 512 bytes copied, 0.0243797 s, 21.0 kB/s
> # mount /dev/loop0 /mnt
> [  271.915595] NILFS (loop0): mounting unchecked fs
> [  272.049603] NILFS (loop0): recovery complete
> [  272.049724] NILFS (loop0): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
> # touch /mnt
> # sync
> #
> 
> I think the dummy write is a simple workaround for now, unless
> mounting NILFS2 at boot time.  But I have been using NILFS2 /home for
> years, I would like to know better workarounds.
> 
