Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4F0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271632083E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGGEgHv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgFVH6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgFVH6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:58:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486F1C061794;
        Mon, 22 Jun 2020 00:58:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g21so10291319wmg.0;
        Mon, 22 Jun 2020 00:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mMMBH/im23ji4fEv1Kmx2CsCljHtX5RHIV2g8cbxlsI=;
        b=IGGEgHv3uSNDTYPQJ0KWiZkYDdsMf8Tt1uPKDhwyFavNMq1RCjG1qohBugu+bUGLuf
         29FhdFTm5mG6F998JXZg7+bwxGtW9166GkrMmBmBCmRRttQSOERMJDT7Znx0qMmj42l2
         9fPRHpKljOLFxFU4Pmvw0P03xuUUUcUO5U9uV2nFEUFQcye0TJRCDe89oFPNUS111+cL
         UvaY0Gc1UeaHUrfCtKRXRJco3NTiu457KXzdbxR5WByO5nfoHmIQu7pwepFOpx6gS0Te
         Ns9IMgLEye3pYx6wC4A1GT+ZHf2vYdM67JNQnORV8vOwV953iwcyi1pOXM77myQ2tKA8
         IubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mMMBH/im23ji4fEv1Kmx2CsCljHtX5RHIV2g8cbxlsI=;
        b=K+7RPiS5xxCBdRy5wQ41A1lhUtifw362e81MCA93AWlDPJPAehjoDfpgWs/IDUiTQw
         xAkp+FcO2MghCOopCj1SnGjADbnxb4Yp0b+h8A/a5fZyMOfX7SjfLwr/n2ZekHTGk6y2
         X+BV5ED7TBG/FUlDA9FVMkTEaolIHM3SLbzU1PSv36mPBPTJIDp952naThtobnHXHA53
         0A8WbbGs4NfMb+jjTY+BWO93NDWZOuaTz74A5bNdMOX79rK0P+Zu+zSDCKjLKwK+bER+
         8RnGAp8+1opsOhooiQ/x8ZnC6Pymp1Hju5+DlHrv44jYMPti5MV2HJ/woxXhtJiBNjTV
         4LeA==
X-Gm-Message-State: AOAM533fDlslJ+VMwCQnyxQjjqy94ZjKcl8MAi5UFbK8Xjjqu4t98bgu
        RHjxQFEbndonfyai8c0MbH0=
X-Google-Smtp-Source: ABdhPJzDatIBw65qbZ5xHtyEjDhL1ClxOVFqmJb4kWMFvawdCgy+PRswhDHVwQx5Mv0OCGrL4+RRBQ==
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr6908746wma.180.1592812719000;
        Mon, 22 Jun 2020 00:58:39 -0700 (PDT)
Received: from [172.22.36.87] (redhat-nat.vtp.fi.muni.cz. [78.128.215.6])
        by smtp.gmail.com with ESMTPSA id b19sm22358112wmj.0.2020.06.22.00.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 00:58:38 -0700 (PDT)
Subject: Re: New mode DM-Verity error handling
To:     Mike Snitzer <snitzer@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     JeongHyeon Lee <jhs2.lee@samsung.com>, dm-devel@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        agk@redhat.com, corbet@lwn.net
References: <CGME20200618070250epcas1p409eb2ddd19ecc5d55c219ac3dc884f25@epcas1p4.samsung.com>
 <98eac3fc-c399-625d-5730-29853b3a0771@samsung.com>
 <20200618154444.GB18007@redhat.com> <20200618165006.GA103290@google.com>
 <20200618170952.GA18057@redhat.com>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <b7eaf4a7-6692-ffdf-2bbc-b622f93ef601@gmail.com>
Date:   Mon, 22 Jun 2020 09:58:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618170952.GA18057@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2020 19:09, Mike Snitzer wrote:
> On Thu, Jun 18 2020 at 12:50pm -0400,
> Sami Tolvanen <samitolvanen@google.com> wrote:
> 
>> On Thu, Jun 18, 2020 at 11:44:45AM -0400, Mike Snitzer wrote:
>>> I do not accept that panicing the system because of verity failure is
>>> reasonable.
>>>
>>> In fact, even rebooting (via DM_VERITY_MODE_RESTART) looks very wrong.
>>>
>>> The device should be put in a failed state and left for admin recovery.
>>
>> That's exactly how the restart mode works on some Android devices. The
>> bootloader sees the verification error and puts the device in recovery
>> mode. Using the restart mode on systems without firmware support won't
>> make sense, obviously.
> 
> OK, so I need further justification from Samsung why they are asking for
> this panic mode.

I think when we have reboot already, panic is not much better :-)

Just please note that dm-verity is used not only in Android world (with own tooling)
but in normal Linux distributions, and I need to modify userspace (veritysetup) to support
and recognize this flag.

Please *always* increase minor dm-verity target version when adding a new feature
- we can then provide some better hint if it is not supported.

Thanks,
Milan
