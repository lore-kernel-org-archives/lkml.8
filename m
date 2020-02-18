Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E4C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D277206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6SQBfP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgBRD3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:29:47 -0500
Received: from mail-vs1-f50.google.com ([209.85.217.50]:35131 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgBRD3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 22:29:47 -0500
Received: by mail-vs1-f50.google.com with SMTP id x123so12116682vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 19:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YbgargU8ALt/nB7SKZ47CKsWwNRksvqKNRcpqJ5pJaY=;
        b=C6SQBfP/3lWrTAbqqzMBz6OaMETT7vd+QQl4EDgYtpGlZadacauvO8mm7NfV3/TdKP
         l5ApZpKYFbHkT9QHK07VxzQdhGHuDFCuZmBkH7iGdxOTeKRJuH8yhdiLFbga2MiqeHbN
         O76knK3XkI/bxAuqoBYJdaH1UMzwuX3wXS/hXW8uMf+t/6hBG3vzJD1ZCHvpnefdEAuF
         eH1Dmaqq0gjMxfjDAZUfytazW+yJeZDcf0/bhfTjqEWE1+WElkE1kpWJ5yRnx5ay8HY6
         8aDh4D2QEpX87b8LulLz4Yg3LpP0joHu/tZEz3mVEWBxsXDIdX4rg3DSDtAgjiTKLiCC
         TOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YbgargU8ALt/nB7SKZ47CKsWwNRksvqKNRcpqJ5pJaY=;
        b=RUhZopJIHA6ajmz6CIC73ZcAFSbw9iVDhOaVRBPOiqJdg46bG5EyRW36GyvGmawLbx
         Uj5pK1XME8Xi2SECYv1iiTjYTlIS2qgnfN8r/JWnoPviiZ0Nop+J1PFJ+xHn696tPg23
         s4bruwcXDEsSe9PmS9hxorlHNkTKZBLuFii9b28NihIfUp9CTNQuulAtloHsqyCXDMl6
         FLQ//3VGyHPmtt5cBnveNX8gUfP9kHWV2pADiKhMvm+aZgvbLUcFpIjFA42jAjJSVf8u
         A/UsOlSAKUAPUtDxD1JjrVUeKqTb4Qw89xCxwdHoqz6o5z7pJvbEEszjKhKQ7IskirIO
         mmMQ==
X-Gm-Message-State: APjAAAVRLQnxlNpfYqh++NYt/DJ1ItedoGfupjGBWeVRHuP4oqCnPC36
        Mg4xsUbyRRx7NT0oImlJZq20jwKGC+/CX101oq4kCrGX
X-Google-Smtp-Source: APXvYqy51ydPUyoqm1C5w+gY2wDmNGWhEgGXYrZrn8CdXyb9UCloDUjh+O+RTKlr2xyM4Tlr8UBvFXe4R3AeKfF1deo=
X-Received: by 2002:a05:6102:2333:: with SMTP id b19mr9842380vsa.230.1581996584460;
 Mon, 17 Feb 2020 19:29:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:4186:0:0:0:0:0 with HTTP; Mon, 17 Feb 2020 19:29:43
 -0800 (PST)
From:   Kent Dorfman <kent.dorfman766@gmail.com>
Date:   Mon, 17 Feb 2020 22:29:43 -0500
Message-ID: <CAK4PFCVLc4=J2nD8-LYXU61N25pxiAKmev2DMGveH=LaL-DfAg@mail.gmail.com>
Subject: need to identify slip interface in a pool (not subscribed to lkml)
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey gents.

As is usually the case, engineering decisions were made before I came
on-board, and now I'm stuck dealing with plans that I had no input
into.

Anyway, company advertised to external customers that they could
connect their widgets to our system using plain ole uncompressed SLIP
over RS422 serial (four wire, no flow control, 115200bps)

Problem, as you may have guessed, is that since the lines are
statically allocated I need to be able to assign static IPs based on
the tty port they are using.  I haven't used a SLIP dialup since
mid-90s and from what I remember, the sl# link is dynamically
allocated based on the "next available" when the slattach command
handshakes with the other end.  This leaves me without knowing what
sl# interface to assign the IP number to.  The common use case was
always a single sl link over a dialup line, not 16+ different
statically allocated slip connections on a single server (with no end
user authentication to define the IP on a per-port basis)

What is my work-around?  How can I know which sl interface to
configure based on a particular tty serial link?

I'm not a LKML subscriber, so please CC me directly.
