Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EF5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE3C20720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CoLuSu+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgGFLxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:53:25 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:54675 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgGFLxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:53:25 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200706115321epoutp031b11f6797596bb9140452bfaeea91262~fJ6l66Gef1566215662epoutp03e
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 11:53:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200706115321epoutp031b11f6797596bb9140452bfaeea91262~fJ6l66Gef1566215662epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594036402;
        bh=YWg4luROLP4xBfYG4qczq7X6qEYCnDiWFsPOOppQygw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=CoLuSu+Iat8YGHYQl9Z7e8HOUhi39FwXRvzXs+ldki0N8IgxaVmD2ck7SX2i3+CKa
         XFFTM9c3JafdNcrSDkgU+RXP3T7OQTXpyeT/0bXaHWzT043U/dc7WfpEDfVLsk7sdy
         Zw3G/33/0PmSJXiVKfnSWoeRHE6RagWJdYZDdWwQ=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200706115321epcas5p491b6d727c6a794a976ed928f07e07263~fJ6lBgaDw2065120651epcas5p4F;
        Mon,  6 Jul 2020 11:53:21 +0000 (GMT)
X-AuditID: b6c32a4a-4cbff700000025e7-ba-5f0310b00d30
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.18.09703.0B0130F5; Mon,  6 Jul 2020 20:53:20 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] fs: fat: add check for dir size in fat_calc_dir_size
Reply-To: anupam.al@samsung.com
From:   Anupam Aggarwal <anupam.al@samsung.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC:     AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        VIVEK TRIVEDI <t.vivek@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <87zh8gct29.fsf@mail.parknet.co.jp>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200706115303epcms5p262a630cd1517632c48e4f72a68d98b0c@epcms5p2>
Date:   Mon, 06 Jul 2020 17:23:03 +0530
X-CMS-MailID: 20200706115303epcms5p262a630cd1517632c48e4f72a68d98b0c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7bCmhu4GAeZ4g3dTLC0u7k61mD53A4vF
        5V1z2Cxe9m1kc2DxuP820aNvyypGj8+b5AKYo7hsUlJzMstSi/TtErgytv96zlSwUbziSfNi
        pgbGFuEuRk4OCQETia1r5jJ3MXJxCAnsZpR492whkMPBwSsgKPF3B1iNsICnxL9T+1hAbCEB
        eYnvCz4xQ8T1JRac7mEDsdkEdCXmvpjNCmKLCBhIPFx+hA1kJrPAJEaJndMfskEs45WY0f6U
        BcKWlti+fCsjiM0J1HBhzweoGlGJm6vfssPY74/NZ4SwRSRa751lhrAFJR783A0Vl5E4sW4N
        I8gyCYF+RolnH1uZIJwZjBJX1zyG2mYusXvDPDCbV8BXYtb9ZjCbRUBVYsPWJqhJLhL3Zk0D
        izMDvbn97RxwSDALaEqs36UPUSIrMfXUOiaIEj6J3t9PmGAe2zEPxlaWmHrtNSuELSnxuLMV
        6mgPicmbp7JDQvoks8Siux8YJzAqzEIE9iwkm2chbF7AyLyKUTK1oDg3PbXYtMAoL7Vcrzgx
        t7g0L10vOT93EyM4bWh57WB8+OCD3iFGJg7GQ4wSHMxKIry92ozxQrwpiZVVqUX58UWlOanF
        hxilOViUxHmVfpyJExJITyxJzU5NLUgtgskycXBKNTBNUmxd/SVEZP1BnZNfuhmmSLaK6Hon
        8rPK3/MT33D4ArOIZPe1c7s3+Z9ZZavqzxTwbBGv/9sbal19OeeP5MZVzyu/fqbxfFuAmtGM
        oy6xzzTfxHMbHBHJ8EzZfnHHPfelfME7fpbkqzx4eWmuAAPb0Z4rhuL7+L1+xq59dWvdJv6J
        Ugb59Q+WqHu/Ka9KmdnjXjRh+/ry7h/rprD59/I5GMcf4tn8v2ifx7ZNZqxdkt9/rPBP+CsQ
        e1ThtZS7qL/nPFf/t48ede4vm7flbO59l11Ppny1/rl0NwPDLRvPXbFTdsV/m7jBSIqJI/5q
        MPe0GX0h9eve7Wyawrhuaa51Xvy8otdO04v/8b3x12BUYinOSDTUYi4qTgQAXp0twooDAAA=
X-CMS-RootMailID: 20200629110320epcas5p34ccccc7c293f077b34b350935c328215
References: <87zh8gct29.fsf@mail.parknet.co.jp>
        <20200630170748epcms5p87fa9b4348c1448d2d5a5f6cdddbc021e@epcms5p8>
        <875zb8o6zh.fsf@mail.parknet.co.jp> <87ftacolpf.fsf@mail.parknet.co.jp>
        <1593428559-13920-1-git-send-email-anupam.al@samsung.com>
        <20200630123355epcms5p602efe0e4ceedcfe11eae2153c8466678@epcms5p6>
        <20200703142939epcms5p1440ec65f7e8a3e4741ade2496135d747@epcms5p1>
        <CGME20200629110320epcas5p34ccccc7c293f077b34b350935c328215@epcms5p2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ogawa,

>Anyway, fsck would be main way. And on other hand, if we want to add
>mitigation for corruption, we would have to see much more details of
>this corruption.  Can you put somewhere to access the corrupted image
>(need the only metadata) to reproduce?

Sorry, uploading of any file not allowed from within.
So, metadata image is not possible to be shared via. upload.
Can try to arrange few more logs via. fsck.

>What happens if you recursively traversed directories on Windows? This
>issue happens on Windows too?

After connecting USB to windows 10, when corrupted dir(\CorruptedDIR) is browsed,
it shows 2623 number of files and directories, without delay.
Name and timestamps of those file/directories are garbage values.

Further if we browse these sub-directories and open files of corrupted dir(\CorruptedDIR)
following popups are coming on Windows 10:
1. The filename, directory name, or volume label syntax is incorrect
2. Specified path does not exist. Check the path and try again

So issue of un-ending browsing(ls -lR) of corrupted USB is not coming on windows 10,
it lists limited number of files/directories, of corrupted dir(\CorruptedDIR) without delay.

>BTW, if you run fsck, the corrupted directories and issue are gone at
>least?

Yes, issues are gone, after running "chkdsk /f" on USB, on Windows 10 PC,
corrupted directory(\CorruptedDIR) is converted to file of 1.06 GB,
so issues are not coming further.
Following is the output of chkdsk write only mode.

--------------------------------------------------------------------------------------

chkdsk /f e:
The type of the file system is FAT32.
Volume AAA created 12/28/2018 3:15 PM
Volume Serial Number is 1606-72DC
Windows is verifying files and folders...
The \$TXRAJNL.DAT entry contains a nonvalid link.
The size of the \$TXRAJNL.DAT entry is not valid.
Unrecoverable error in folder \CorruptedDIR.
Convert folder to file (Y/N)? Y
\DDD\file.txt is cross-linked on allocation unit 736512.
Cross link resolved by copying.
\BBB\file1.txt is cross-linked on allocation unit 433153.
Cross link resolved by copying.
\System Volume Information\LightningSand.CFD is cross-linked on allocation unit 1114114.
Cross link resolved by copying.
\CCC\file1.txt is cross-linked on allocation unit 179989.
Cross link resolved by copying.
File and folder verification is complete.
Convert lost chains to files (Y/N)? Y
3531520 KB in 31 recovered files.

Windows has made corrections to the file system.
No further action is required.
   30,015,472 KB total disk space.
          400 KB in 2 hidden files.
        2,816 KB in 49 folders.
   23,470,800 KB in 7,616 files.
    6,539,408 KB are available.

       16,384 bytes in each allocation unit.
    1,875,967 total allocation units on disk.
      408,713 allocation units available on disk.

--------------------------------------------------------------------------------------

Thanks,
Anupam
