Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D93DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552B620747
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMjDEe9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgFKMhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgFKMhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:37:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B28C08C5C1;
        Thu, 11 Jun 2020 05:37:24 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c17so6674729lji.11;
        Thu, 11 Jun 2020 05:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7pw6B9iRk8cxXinJlBDcvCUW06xNfgnr8zarLwpvFs=;
        b=oMjDEe9O0rdA8BxLxhemg2EvkT6vuf/OGAx/tIwuF8v/zx8eCKhShBirRkcxjUf0H7
         kABjw35/v8vLd3h8bmEhNgUBwJtlFk4jIwYKUcJ9E2h5WjFmYUcf9XJo0tXZknooTVKz
         AoPjuHRnX/JH8pgbfmy94gSfbE7d5duPf8iyXtRYbVjUoqzgaOmsSNElA0yivdxPAZ52
         ibLMXIWWhsFFnkmq3OCUaFq9SiLqKwKw7WRKvFKzkuQ31L8ds+4iDNZupjxv9CvbBUF7
         RjZE3qqhV+wa8CEltnKr3Q7qOcyfMi8Cjwwxvb8680x6PH3bGr7iw4bnCUAWoPLHABcr
         SHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7pw6B9iRk8cxXinJlBDcvCUW06xNfgnr8zarLwpvFs=;
        b=L6dTK4Ugxv4lYajGyWW6Y1v8guofxDW3kSTXejzCKNIKrQ4KpHfn/7yF98RqfDAQCS
         GXIoNOl7di/TeQPNfIQ74Hm09tEUJxei5TKVaj0DS3rt9cIuQgrMh2AnNFE0tdF2L8OU
         NiLhYw6ff3DcaIbNV4FIlqpRCDFZZz0zeumSJS3rdXUEaTVdpKHbTJe1Q0YwGF3KhR1e
         Fg5nM49RCSMzOlkxowdYi5an7GshzShDfiBKyYY/uMI7IzN58FR9/zUfz/vweKiUKlPt
         RDpaPKVydanm0waUC1y+Ju/zsV9Lg40bKBjIkDYTSPu2hobIRFrk6ut3lzeAmjxvPMlf
         pRgw==
X-Gm-Message-State: AOAM5301XB6mAOps7aMghWH5QJD9yUlqTgv4V9LmWJiWgku7Y+x/Fm8X
        IPuaJSEKy5v0QDjs0A2moICTAmzVtwQ/yYwbzr/TsEUGo5k=
X-Google-Smtp-Source: ABdhPJxDM8KrtXX8IGgPK2/k1ttJubEAwj648kPXYtV3zoabWptLMjeIUPyvvokZNJ5ypTgF1FndSTYyXvj6lsSwAaA=
X-Received: by 2002:a2e:9b04:: with SMTP id u4mr4593898lji.364.1591879043027;
 Thu, 11 Jun 2020 05:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200609201241.81518-1-grandmaster@al2klimov.de>
 <4235548.LvFx2qVVIh@harkonnen> <cd260d03-27a4-7794-f58f-21e8e0be9755@al2klimov.de>
 <202006102009.CB14D7F@keescook> <8ee16c38-e28b-b4e6-ed30-55a59e216b49@al2klimov.de>
 <CANiq72n50OVRtFAQkAmqjaj=dJTP9VqYYHN7++8O_t4cbfaJgw@mail.gmail.com> <3a6354fd-90ec-914f-b5df-0c4c219bd26e@al2klimov.de>
In-Reply-To: <3a6354fd-90ec-914f-b5df-0c4c219bd26e@al2klimov.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 11 Jun 2020 14:37:11 +0200
Message-ID: <CANiq72=-B4SJvo5kgyUbmBJho9625Pp6SWjki-TRhMfpmj0wUg@mail.gmail.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: Documentation/translations/it_IT
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 1:02 PM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
>
> Who if not Linus shall review one huge patch spreading across lots of
> subsystems?

Even if a patch is tree-wide, ideally it is first ack'd/reviewed by
each subsystem maintainer. The overall idea is that changes are
reviewed by several people. Thus sending patches directly to Linus,
Andrew Morton, Greg K-H, etc. without previous discussion is a last
resort.

Cheers,
Miguel
