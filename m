Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B847C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014192256E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="dGj+L6eM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgFTQVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgFTQVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:21:05 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC6AC06174E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:21:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g18so3430678wrm.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=LsdlsAsjU54chv5A3f6bZ+ANBAyVCJnJe+gBOxPLMj8=;
        b=dGj+L6eMYq2DRudFKsbXZto+0iYChTcEGjN3nX2eLorI5BvJ5GrU/qBPLsaBfmWy4E
         nY1i7qhl/ZgZjCBJwPPIjis79CvIkXZg3vecd5nfDV0AlL1Ja8COnbOVayOwBksn/XFh
         +lf2Bs1/vpQ1eEQDA/Pb87nBokqM8iPEPVnsb8u9jPQ2XUvjHMmqebEZ4PUm5MKe664Y
         IjYAP6JUxxA+KJDv0nVHloo92gNXn8bGw25g7tdswdZoXeiqsLqSAxWA2d4WMBB+ACOp
         JbsNKRDk1nyyVfX1HNpd5JrKfUoxCDztO9S2wbqU2Jm0fIr+EWBL50DPZOAI1uHvjNIH
         hYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LsdlsAsjU54chv5A3f6bZ+ANBAyVCJnJe+gBOxPLMj8=;
        b=mA1j6j9AExv3e1sKQB25/vbthBTDr3OKnWU8qRD+S+4/vtEglKfaBRdtNYVR0bIWv1
         MINeI3JfefCco8U7NwUTp8sflIwPiL5upIe0RddioKSEfLcTW/OuZ6P7KXJUOoEx9hVB
         oofBNFCWmNk51kXTk7+apQzaFdx8Ja2m3wQDLkyq7sUKdY7CpfgDiscQqjt5tVBHMLLY
         DuL0t4yPEKDWZFn52ym7co21A0RV9QUch25puV7psxiyl4MiRqmYGOigMF7T+fXNr2b+
         AjraI9/Pnk7xKdT7oQ3jbf/4MPGfWwac1OSKNHFMXScec8dQ888TeMI9cxQyAtjIQhb8
         9x5g==
X-Gm-Message-State: AOAM531ixxsngBn6JYGi9hsZfhID9ZEWYXxkhHtx8vmo/rk1bpQMH5zA
        oj/FwSV0OTAz5bMdpiQVgiqde0B1QIH94iKv6iEHsM5Z
X-Google-Smtp-Source: ABdhPJzbl255ooHNNsbT/yVORpNixIyeaTHtNHVGOPMcADCWOx2+5pztheSUu32xQDNneUzwDk8Y/0NHgLjiIxPyChY=
X-Received: by 2002:adf:ea11:: with SMTP id q17mr9633892wrm.75.1592670061717;
 Sat, 20 Jun 2020 09:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrU_O4AxcJeBO77uXt2j8woYVtjZd18-YV0BuCKRAu00eA@mail.gmail.com>
In-Reply-To: <CALCETrU_O4AxcJeBO77uXt2j8woYVtjZd18-YV0BuCKRAu00eA@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Sat, 20 Jun 2020 09:20:50 -0700
Message-ID: <CALCETrVDfdKvNorB0Um7HBABK-U1NJLWTEu+kxzTXAWL_eZUVQ@mail.gmail.com>
Subject: Re: Linux FSGSBASE testing
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Stas Sergeev <stsp@list.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 8:59 AM Andy Lutomirski <luto@amacapital.net> wrote:
>

> 2. FSGSBASE off on a patched kernel.  Boot the same kernel as in #1
> but either pass nofsgsbase on the kernel command line or use pre-Ivy
> Bridge hardware.  You will *

You will not see fsgsbase in /proc/cpuinfo if you successfully
disabled fsgsbase.
