Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846D3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E645206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X4EKdamM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgFEPai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgFEPah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:30:37 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303EAC08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 08:30:37 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id p18so7783914eds.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=kvw05eX12Yh5FgPlRgUSXlHOGxXXNOE9RCalQGq26Xo=;
        b=X4EKdamMjiSiB2U3W8O5PY6qGT/gQ3iDtOq81oo4CwFUfUs4QtVFNAIgUhQIez2JvK
         RD0pzFl//irlgsZeeSP74HYMXDs1vDpoaB+QCypLSWwheaLyS9SoUVYBdUffe8ZpnFm8
         DWSAEQXMks9fdXHdJu3fgbIwLiNOtJChxYCKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=kvw05eX12Yh5FgPlRgUSXlHOGxXXNOE9RCalQGq26Xo=;
        b=golrXaBOk65bOk1ycsJUJZv++jK9OfUk55i31Wq7Cs6kUl5jnyk4OrZGLi4aTg44XK
         hnttInlXXGAO8zb/Gnqz/n+6MKphdOHNji58Qct+EgbMYXEfzUhafeWezWVSkd5ZY8fU
         rYzVdC2woj4xeyJg4C4PSChNSA/W2Xa10NtgCI4v2kJGibAY2pv9wWmR8XnMP8TZeWR+
         SG53OaCHf6FFPh0hw4PmTfIdk1PtF/ELvILpWLEvcOAIO5oGCqN+Ov2FKWNizuSRdVh5
         mTctQmduGpGK3DsrXlB8j4manW8eKpwRIQtNytYrtrCKDSeAYJdwR2nvaj4mzZqKxp2U
         +FGw==
X-Gm-Message-State: AOAM530WpJxWF8jZ8iuS68JB/60qye5dK8mxw9e2XuSw4Pl97bUU+gF6
        0+dZT2PY5t/QUTwr0Eekf6RlyFcft5T+4tW1Xq1CHQ==
X-Google-Smtp-Source: ABdhPJzysky/6m/7l4XT3DGaswXSvfsR/17IejP2A8NgogK397u5AbKSPlAhBht80tUh9/J3O0fP7nqA+lWIyObcMo0=
X-Received: by 2002:a50:f9cc:: with SMTP id a12mr9988020edq.227.1591371035564;
 Fri, 05 Jun 2020 08:30:35 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
References: <1590651115-9619-1-git-send-email-newtongao@tencent.com>
 <yq17dwp9bss.fsf@ca-mkp.ca.oracle.com> <4779a72c878774e4e3525aae8932feda@mail.gmail.com>
 <20200604155009.63mhbsoaoq6yra77@suse.com> <4285a7ff366d7f5cfb5cae582dadf878@mail.gmail.com>
 <20200605043846.f3ciid3xpvdgumh6@suse.com>
In-Reply-To: <20200605043846.f3ciid3xpvdgumh6@suse.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJb9Wzm0098wwdcUnfhuPbO5i84ZwGnJavmAYBmkM8CEG/qNQHLP1nqAXBxbNenexM2cA==
Date:   Fri, 5 Jun 2020 21:00:32 +0530
Message-ID: <599e459f0a657fed8a262a34f43b035c@mail.gmail.com>
Subject: RE: [PATCH] scsi: megaraid_sas: fix kdump kernel boot hung caused by JBOD
To:     Kai Liu <kai.liu@suse.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Xiaoming Gao <newtongao@tencent.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>, xiakaixu1987@gmail.com,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Subject: Re: [PATCH] scsi: megaraid_sas: fix kdump kernel boot hung caused
>by JBOD
>
>On 2020/06/05 Fri 01:05, Chandrakanth Patil wrote:
>>
>>Hi Kai Liu,
>>
>>Gen3 (Invader) and Gen3.5 (Ventura/Aero) generations of controllers are
>>affected.
>
>Hi Chandrakanth,
>
>My card is not one of these but it's also problematic:
>
># lspci -nn|grep 3408
>02:00.0 RAID bus controller [0104]: Broadcom / LSI MegaRAID Tri-Mode
>SAS3408
>[1000:0017] (rev 01)
>
>According to megaraid_sas.h it's Tomcat:
>
>#define PCI_DEVICE_ID_LSI_TOMCAT                    0x0017
>
>According to product information on broadcom.com the card model is 9440-8i.
>So I tried to
>upgrade to the latest firmware version
>51.13.0-3223 but I got these error:
>
># ./storcli64 /c0 download file=9440-8i_nopad.rom Download Completed.
>Flashing image to adapter...
>CLI Version = 007.1316.0000.0000 Mar 12, 2020 Operating system = Linux
>5.3.18-
>0.g6748ac9-default Controller = 0 Status = Failure Description = image
>corrupted
>
>I tried few more versions from broadcom website, they all failed with the
>same "image
>corrupted" error.
>
>Here is the controller information:
>
># ./storcli64 /c0 show
>Generating detailed summary of the adapter, it may take a while to
>complete.
>
>CLI Version = 007.1316.0000.0000 Mar 12, 2020 Operating system = Linux
>5.3.18-
>0.g6748ac9-default Controller = 0 Status = Success Description = None
>
>Product Name = SAS3408
>Serial Number = 033FAT10K8000236
>SAS Address =  57c1cf15516f4000
>PCI Address = 00:02:00:00
>System Time = 06/05/2020 12:36:59
>Mfg. Date = 00/00/00
>Controller Time = 06/05/2020 04:36:58
>FW Package Build = 50.6.3-0109
>BIOS Version = 7.06.02.2_0x07060502
>FW Version = 5.060.01-2262
>Driver Name = megaraid_sas
>Driver Version = 07.713.01.00-rc1
>Vendor Id = 0x1000
>Device Id = 0x17
>SubVendor Id = 0x19E5
>SubDevice Id = 0xD213
>Host Interface = PCI-E
>Device Interface = SAS-12G
>Bus Number = 2
>Device Number = 0
>Function Number = 0
>Domain ID = 0
>Drive Groups = 3
>
>
>Thanks,
>Kai Liu

Hi Kai Liu,

Tomcat (Device ID: 0017) belongs to Gen3.5 controllers (Ventura family of
controllers). So this issue is applicable.
As this is an OEM specific firmware, Please contact Broadcom support team in
order get the correct firmware image.

-Chandrakanth Patil
