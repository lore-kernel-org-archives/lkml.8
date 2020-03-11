Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00658C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58C720739
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbSHiffg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbgCKWan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:30:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39670 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729799AbgCKWan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:30:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id w65so2158072pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 15:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=VxId/5R2+lzGKp4xsQtvfpVORMMHYVxgyqrgJySMYzY=;
        b=TbSHiffgBHgwXtx6lWGtUCIGwYo7aHUsh3UxIgr4iUYGZj78Lkbv3m0bjNFEsPt+/G
         0aomm2mocu8Rf+ku5opnW2fnZ/LiSJ3eE8sRt1RZNJlFdGa0RJnRWRxX8yulkaJjZb+4
         I0Wq7BvsQpJObzG9dYfRtLMo7agM/Z13SNVfjv0rAxaVjvwZcFME9jKgB5GqQ2GJUYQS
         +AH08f80G47e5pKa7h7HIxxP3t67tHVKGrTW6AnglzAQK62Spb6YJrGFNtHSCDxYzGdZ
         UK8EQIeIqZ0S6KqtKjYpU8EDkerh/V7WIOPN72DAbjdzhMimCQITvjoa3Yivn9ZwM03c
         smjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=VxId/5R2+lzGKp4xsQtvfpVORMMHYVxgyqrgJySMYzY=;
        b=mZGIx59DNqP1cm5QBxNVizKBTiB0ffvCzHUKeLzqUU9XPvoU74mxmAQOHxxXkADGZD
         UaD69vYgsJ00Y883DRHNLvvqKQwi7VfZJW5xDW5/G3NQw+gOX6j4wu0zqV+ic/8Yx8x+
         m5o3dJ3sBD+G6XmkzRQeVXH+gvqOvfd+Qg17bWnWuV5rFWeGUeCd5BxmXK61PSxeQmMs
         PQc6jM0pAUhwKcLNxHdMdnP/xKVTNSR0So/c/WihiZMaGm93FPDkJ0+6dXJ4ZAhhGmcF
         u6zKr4Bv9Tue0CJck3+ysxRF/cayB5H/c1A3p0t686Xos1ybv9LVIuP2fvHiXw3Sr/Lu
         S2OA==
X-Gm-Message-State: ANhLgQ0gR8n/4F9h0FkSgbfHKHREymDyuTzdwJOhW2a4y4X4liFjLhms
        gOcMb7XxXbtOR60FeOTUrEE=
X-Google-Smtp-Source: ADFU+vvUdUiZ/3I5RAU7v1jAZt0rsCbzS2PwzEvQdXDuFP/h0EjEUfZ4WMu3QLeSizzxjP2xBkZa8Q==
X-Received: by 2002:a62:f842:: with SMTP id c2mr5017437pfm.104.1583965842272;
        Wed, 11 Mar 2020 15:30:42 -0700 (PDT)
Received: from [192.168.0.100] ([113.193.33.106])
        by smtp.gmail.com with ESMTPSA id v5sm1592244pff.209.2020.03.11.15.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 15:30:41 -0700 (PDT)
Date:   Thu, 12 Mar 2020 04:00:40 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20200311180428.6489fe9b@elisabeth>
References: <20200311131742.31068-1-shreeya.patel23498@gmail.com> <20200311180428.6489fe9b@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Outreachy kernel] [PATCH v4] Staging: rtl8188eu: rtw_mlme: Add space around operators
To:     outreachy-kernel@googlegroups.com,
        Stefano Brivio <sbrivio@redhat.com>
CC:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl,
        Larry.Finger@lwfinger.net
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
Message-ID: <181B01E8-5D92-458F-9C5E-7271333B96F4@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 11, 2020 10:34:28 PM GMT+05:30, Stefano Brivio
 <sbrivio@redhat=2Ecom> wrote:

Hey Stefano,

>On Wed, 11 Mar 2020 18:47:42 +0530
>Shreeya Patel <shreeya=2Epatel23498@gmail=2Ecom> wrote:
>
>> Add space around operators for improving the code
>> readability=2E
>> Reported by checkpatch=2Epl
>>=20
>> git diff -w shows no difference=2E
>> diff of the =2Eo files before and after the changes shows no
>difference=2E
>>=20
>> Signed-off-by: Shreeya Patel <shreeya=2Epatel23498@gmail=2Ecom>
>
>This looks good to me=2E Further clean-ups here could probably make this
>look less messy (there are long lines, unnecessary parentheses that are
>rather confusing, especially on that 4/5 factor, "magic" constants that
>might make sense to figure out the meaning of, etc=2E)=2E
>

Thanks for reviewing=2E I will surely look at the other clean-ups as well =
:)

Thanks

>Reviewed-by: Stefano Brivio <sbrivio@redhat=2Ecom>

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
