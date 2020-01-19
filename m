Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E28C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 09:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30602073A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 09:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaJK03Yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgASJ07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 04:26:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41495 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgASJ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 04:26:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so26488270wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 01:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=U3SRtIVUFf1wvhswIJpjjxOJSs67OuTrUXH2Ak0AKwg=;
        b=OaJK03Yd0UMqCnEKR9cR5QGcUJM1kaw0UR2QJdLuxZbKSd1N0CxdDGfFhQInbUoN8t
         2Q2eLVZzv2/WJQoY7jmbMV4Z2npedPvc7te4FL0rsOYyOaB0oQv2uU3r9U04PsQq3ziM
         pUSrpt8IBQEqTYSR8uU3mBuxoeMQS8prnFOMZ5v/47dlZNN6xOLvWDAqGssRZL/7nmzD
         rZC3uhUeKbxy64w9IhXDUfb9KUkenQfICa+CUYD6xm/NObH5kdl7cdTrogxcMY6G4BFy
         o4rtEwCRKbuOAwo82MacQ9qw9I8V2vYaQOS181OmJOtzDRN5KtMrBYnvaivnEjzamf5V
         tLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=U3SRtIVUFf1wvhswIJpjjxOJSs67OuTrUXH2Ak0AKwg=;
        b=DMRTzHVrc6Y5lGtPWqZ2uCLcy2DkCZVzFaiavLqQHb9KSp6V2UFVAOrn5iLpUv3JcK
         P1rrthOMXuxYA/mvoAd0u/dcl75B6TLwBvjas+kyfxSNWiXVDDemPhGMQzdbEvTCBVmh
         Sg/zP+w5tpMBqdqoS+PMEIj9Z9kKUNdLwn4COnMNrFDI66DPNrjnwsA3/QJMvctnaWJR
         HYQU8sZKI+2Q2bKncEXK/r3Fo0yCfyXDMlM9q3PtAcU4wnVTM6SYeXFNKy1qciFZ7ezx
         1NArWmoWY5cXrtqIxSiJEzgmJKqK3AcvxbnkDzyGMJ+HcMscY+GQkLfJL1cLSlqz6Ne8
         1qUA==
X-Gm-Message-State: APjAAAWOYQ6w0erFR/ryfQjE7b82y8yOvQdkBOMSEjNis/sKLjgvCRHo
        tL2FN2BREb2IoD0OJk/DA8lx4Idwkfbw2QYHHvIYOE9y
X-Google-Smtp-Source: APXvYqzX09F2R/BA+aOMieLnrLOJbeXZ8KNMjM7elIY3/u38tsLzvNzbB+EKAFqcMiqYk2pubTxNWR+viwVzztcYKcI=
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr13117016wrs.179.1579426016765;
 Sun, 19 Jan 2020 01:26:56 -0800 (PST)
MIME-Version: 1.0
References: <CAAJw_ZsrUP54N5Ko2PrZm2BnKbxv44pXL3Ycw1Ux2onAFqrOVQ@mail.gmail.com>
 <CAAJw_ZsQkjdPo7McQoEb9LqBb0hzrzFRE4K_CR5dVApoT2_zmQ@mail.gmail.com>
In-Reply-To: <CAAJw_ZsQkjdPo7McQoEb9LqBb0hzrzFRE4K_CR5dVApoT2_zmQ@mail.gmail.com>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Sun, 19 Jan 2020 17:26:45 +0800
Message-ID: <CAAJw_ZuLTxxNyuYeAjhTY+ENQNiOMuQD2p2y2M9J0Urk2MNzKA@mail.gmail.com>
Subject: Re: No realtime clock (/dev/rtc) on new ThinkPad X1
To:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed. Upgraded Lenovo firmware to N2QET18W (1.12 ).

Now /dev/rtc0 shows up!

My best.,
Jeff

On Fri, Jan 17, 2020 at 12:16 PM Jeff Chua <jeff.chua.linux@gmail.com> wrote:
>
> On Fri, Jan 17, 2020 at 11:46 AM Jeff Chua <jeff.chua.linux@gmail.com> wrote:
> >
> > Got installed Linux 5.5.0-rc6 on ThinkPad X1. CPU is i7-10510U (Comet
> > Lake) ... and /dev/rtc is missing.
> >
> > Linux is latest git pull (f4353c3e2aaf7f7d3c5a18271b368bf5292854c3)
> > CPU model name      : Intel(R) Core(TM) i7-10510U CPU @ 1.80GHz
> >
> > Am I missing something?
>
> I can confirm that the same kernel works on another ThinkPad (tried on
> P53 with i7-9750H) but not on X1.
>
> Jeff.
