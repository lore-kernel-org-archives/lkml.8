Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89331C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6846820721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PQLxh8Bx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgEDUBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728083AbgEDUBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:01:30 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6FBC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 13:01:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so14684320edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3/e8Z9+7dUAsUY2FABXXWSYilV/IhKWhqiAxe7AB0w=;
        b=PQLxh8BxfRVNbGhoMqQ+SidqGRLgyNwgg8AMxdhr+hQzfTeHVr36B+yHinyk4RO/N4
         Y6or3TT0f0D5Fk2htAjerP0VkNsQmuf+6kdiRqGxrmqzFx4LeKaq2tJJyV4BLREtMGXz
         OYg6bJ8gAXk19xxFW/6JajQ6o5OgEmm+BlSXGcHzftgStQevaAhOKN4SIQzOWZsmtA2M
         sHN7uXi6oTRnaDA0P8KsZ+qN+PRH+Bz2jlGhskWtqMnQT4Akn2iBxP70/9YiOy2/UExj
         h7tIFeuI5HvEEkvt4yCaBpVupn252Kup6VLqULCGJqBRmjdtUTAeOXz58YCUjCCiXISr
         3d3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3/e8Z9+7dUAsUY2FABXXWSYilV/IhKWhqiAxe7AB0w=;
        b=NHXe6P719mTCOcqbxDmJcKVCeeDiZJSEfv0JrsBqfu9OnB0+XvTQ0nQjWk65O9SK30
         FrEIjLFiUCW5c1X80xgKNvQIrdPSvCXSrEe7ZMSsksnRF6RyZ4CNTs9USrudPYRbRcXR
         W1cHZBhZV+lnVAeWBuZ/RTMR067YTg9D70MrrBnAdpMzNz16GqPNyjkS9H2OuJ+ngzuq
         BisC7ZjZv7zDDvb2H0jJ4tLsK1GhNaJ/so2dpwep2PHl/Ess+av/QE0Rs5u2HZ8m6QNV
         VgwHCfBSL1GC/5vrWf2LHOn1fKc1rPa46KFWQezBL1cXdxo5UNwcbpuHAmstgRMdDC43
         1kWQ==
X-Gm-Message-State: AGi0PuYn3zF19wdfwO+oj16mWYJMMFNtENHu9c+tZh+RB88liM2IjhRk
        O1G+E7fqLGfwqyAA3XWfnea2lMkj4tT+nWNllH3Jwg==
X-Google-Smtp-Source: APiQypJuGrmkU0XtajGtCW6+tnsEvDAvqoXPAkujg8EqXPfFARkabTI9PH5qgtjx1yu+XzN1nobAPxrfByxFFM1kmdk=
X-Received: by 2002:a05:6402:356:: with SMTP id r22mr17037164edw.3.1588622487633;
 Mon, 04 May 2020 13:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
 <202005041112.F3C8117F67@keescook> <CA+CK2bBDzbXdH23aDxqGzMoxPppNcVmitrYJ00tJqympMBVJOg@mail.gmail.com>
 <202005041211.040A1C65C8@keescook> <CA+CK2bAJgKR+=Tby91gU-ZKy29Juv_oJinCTFAWRaKiiro2vkg@mail.gmail.com>
 <202005041230.806B1581D@keescook>
In-Reply-To: <202005041230.806B1581D@keescook>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 4 May 2020 16:00:51 -0400
Message-ID: <CA+CK2bBFQYnFWeDxegR+7rz2nepbK-upqBnRjLgO9JH7oUJoQw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] allow ramoops to collect all kmesg_dump events
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > pstore /mnt/console-ramoops-0 outputs only messages below the console
> > loglevel, and our console loglevel is set to 3 due to slowness of
> > serial console. Which means only errors and worse types of messages
> > are recorded. AFAIK, there is no way to have different log levels for
> > different consoles.
>
> Ah-ha! Okay, thanks. Please include this rationale in the v2 changelog.
> That makes perfect sense; I just didn't see it and maybe others will
> need the same clarity too. Thanks!

I will add this explanation to v2.

Thank you,
Pasha

>
> -Kees
>
> --
> Kees Cook
