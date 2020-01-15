Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B581C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486D72075B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Br2os3uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgAOK2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:28:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33572 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbgAOK2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:28:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so17980228lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 02:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fl2+hd9MOPqIs4AdIyHBX9dTYx9KGtCqWmRO6vACTV0=;
        b=Br2os3ucvC2+tntLkVdA5cJ16P+fmWVjSbnj7VdWkvVHHxoK1LaEJIjdWDCHj8Ckgg
         +fAPPBqF/IXQSDKQeCVlV85ECsPEpHuoQpFgzYbBKEdu89gXKwwF9VFW5KTI3IRZPTBV
         cmfYoL+9tmZWzIotq6YCEPDH9s+jgKX8KUPwH7O/hlReD5KrNtoERgiAmioTyHEWQyzV
         XyMgTf0MdAfAnj2pb1mkEiz4jxmVhWFYdCe8hsUbRTx4zUuc+2JtWeK0XjntyENUxuye
         jeFGBOqjG+1YCYdb/+GRlNzshuGnIjEgep9owtQmkiLemZmtskhmuUwRW+GAI44HEW4C
         jp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fl2+hd9MOPqIs4AdIyHBX9dTYx9KGtCqWmRO6vACTV0=;
        b=Pe6dqnh+pxMMDNC81upspKuMGBosgqa8GTi3T+1GMyvJYML0vHOvLFry9TXSggZWIx
         NSWOOy8OYPVlqnFCB7rWlfmnvZn2TfIlruwYhr877g445RbpHBD9rgR6z/mDVmuyr+lB
         wRqJTMq7eRPeFaA4fBdZXlQE05Y1k0iVvmrL7Tae5xzWc+I9MiakvkRzhz8KBAqnkNOg
         W407GtGlWrmowLMPfbcBzuBYLJm2yR6KLTcYVXfvgM89cVmKrBaNiA0R/lVJPCE5zHVM
         eqPtTlI5Z27yL4uCyfxwCfGUuMhfTHZH0+ZKhMx1p6eQm1pT2q4PZNBzKfa/FnzDOkM+
         Qp6A==
X-Gm-Message-State: APjAAAXzwySEEMbzhzbMhjG+Q+JxJhcgQLZfQTf2PyZ3fcyPlJ3w3N6v
        TBebZ3uAmNNjEJUpFNrBNDiRT1KyByr1QGAep6o1cA==
X-Google-Smtp-Source: APXvYqxaEEPlzZFLh39WCF1YWNM8pO+8/3eb5wMYnow6KlO3Ow7rl0uvCV06EirMeY33Q27yWVMo25R0SKDVRfErk0g=
X-Received: by 2002:a2e:918c:: with SMTP id f12mr1346817ljg.66.1579084094788;
 Wed, 15 Jan 2020 02:28:14 -0800 (PST)
MIME-Version: 1.0
References: <20200114150253.28716-1-brgl@bgdev.pl>
In-Reply-To: <20200114150253.28716-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jan 2020 11:28:03 +0100
Message-ID: <CACRpkda3QhVATZ5of97xDWYnAb6b1o+gMsKE6mDnJrzAUmNV_A@mail.gmail.com>
Subject: Re: [PATCH 0/2] gpio: mockup: minor maintenance
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 4:02 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Just two tweaks to the testing driver: update the license tag to conform
> with the current SPDX list and sort the headers alphabetically for easier
> maintenance.

Thanks Bartosz,

I just applied both patches so you don't need to bother with pull requests
for these two.

Yours,
Linus Walleij
