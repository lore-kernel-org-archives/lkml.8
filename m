Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA61C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401AF206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GjxtAOQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgFDTfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgFDTfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 15:35:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32727C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 12:35:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id e2so7345787eje.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=oyFcjly3iI3BI3+x8EJy7gBmUy6FOed1sXbAZssuOGo=;
        b=GjxtAOQpLRjZNmSyUueh+o5GYU/a2WnPWJ6lUemF++gMlaOuL43n5nkyCy1JOOntFQ
         N5IG9D54Qy0ztQrXQWRSzHY0sM73WSKhqiNtQ6KuMUwOi7+uVXbfp64AR+O9JXuEKwb6
         LXL0lOS4/jEZkRYhN6FORL6w0jcd96qtmEh4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=oyFcjly3iI3BI3+x8EJy7gBmUy6FOed1sXbAZssuOGo=;
        b=shduVYBXKXPrngTLDJfS3q9B0pMwANGrD4xvFsTlLyNd8iWmKHoZAkKQ3zu/6xJrzq
         lIo+LbAYaCwd/shm+AboM3FaH5PlZCNv/vn/pedocEdLenKRK4LDZdLT5bC/Rxr3FTIp
         fCiG1hhR3u1si5BQjLKCHz5yxUVoikzUdqjNA6nS9dA+3KmaksO2JUI939e76fb0Y6o8
         Mr1qJVwgjU1NLbKdJHcd48anfNWaa/XKQt8ObWmREiprji00R4olrC/kcokawTTDmMT/
         fhMQ03w1rNAdhYq0ntIWtrYyTzfG4EvT3M6uahbGCE0nV9n2BTnEAwQNPkuqnc7YHFye
         /PRQ==
X-Gm-Message-State: AOAM532JYuJB/Gvccus2GWCNu/0GMYUtqpuIlO+pU7zwS+8bwVKJV+W+
        DtDFrIwTCqGAaWMedSxPCUtI/6+ghCHnFwUd3C8WAw==
X-Google-Smtp-Source: ABdhPJyPugwFVDV6AFxPuiXuVnUxIjbCmjXK1NRb4zaJGKhfuG6BzP+CkKC8JEeaZLgBDICeXdLhDSKGf2RflapIHsg=
X-Received: by 2002:a17:906:8253:: with SMTP id f19mr5433964ejx.470.1591299317595;
 Thu, 04 Jun 2020 12:35:17 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
References: <1590651115-9619-1-git-send-email-newtongao@tencent.com>
 <yq17dwp9bss.fsf@ca-mkp.ca.oracle.com> <4779a72c878774e4e3525aae8932feda@mail.gmail.com>
 <20200604155009.63mhbsoaoq6yra77@suse.com>
In-Reply-To: <20200604155009.63mhbsoaoq6yra77@suse.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJb9Wzm0098wwdcUnfhuPbO5i84ZwGnJavmAYBmkM8CEG/qNaeTocBQ
Date:   Fri, 5 Jun 2020 01:05:13 +0530
Message-ID: <4285a7ff366d7f5cfb5cae582dadf878@mail.gmail.com>
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
>On 2020/06/04 Thu 16:39, Chandrakanth Patil wrote:
>>
>>Hi Martin, Xiaoming Gao, Kai Liu,
>>
>>It is a known firmware issue and has been fixed. Please update to the
>>latest firmware available in the Broadcom support website.
>>Please let me know if you need any further information.
>
>Hi Chandrakanth,
>
>Could you let me know which megaraid based controllers are affected by this
>issue? All or
>some models or some generations?
>
>Best regards,
>Kai Liu

Hi Kai Liu,

Gen3 (Invader) and Gen3.5 (Ventura/Aero) generations of controllers are
affected.

Thanks,
Chandrakanth Patil
