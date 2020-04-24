Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B160C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1742320706
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587758625;
	bh=xdw11Dwhi3o06xFsSmh1bsJM4Kf4hGk7RjC9g1TqJ/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mRegG78IK9sglmxOOE+rn/qFlA4wz8cCRruRAvpHaTM8e+Z/kgvLAHbVYTsQp3sSc
	 a4yor2qJkdqF8qRkH96L3tKiDtYh3CgIzgcWl32uKueufrDdoaGKcR+8M6Q2KThZ2x
	 mLBLE4HzNYjm7ioo9kydBeJJ49yJylscIzrxAgUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgDXUDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXUDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:03:43 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C775DC09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:03:42 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r17so8746553lff.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKiBGaITMWdq+RcJCKiD/KTBLwCH1eJL3pgyLRaRR50=;
        b=RTCTUpbhuswy3xPMW3RGLlJF3lmnhyCRiVwB/lbeWvf4CUaD1xhJGKhESpvFHrwbnL
         tCHhM4ASu3oXvIwAawcrwqPxV2i+vbr7hayLfIX+RIQg/QzXYPBweoWWoTGgDiiOG1xp
         JD9DhVMgeTcS82lfo5xUOCeCz2bxZN0lUPjzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKiBGaITMWdq+RcJCKiD/KTBLwCH1eJL3pgyLRaRR50=;
        b=ROUuizcyOyH/XOUt0gmUxZpJopuTPYrf34iND0ST9R4GEaRnLdh6isluBwzZEghryK
         VtL7tRJGVldottsJkYuhoujW4f2mqkpC5wkn5qQVKBcqUWASXwEQZhAm3HefgNdEzBkd
         LQUl0ld5ZJEo7iGsQGrhU6q0TGQXE7KkOxB+GO9+I7ctrJRV503tTKLHvrdGdIcKogiA
         4blID5ZJa7fUIuSwwxbz+TByQerApD2o49vWabeP8RKU9FgMTGVGrUZox4PBw+ERRY83
         MYN+QqQlsDXuI0GY4V/oB7XpFo/xsys8s21LKZ//emu+bsTST9t4WmSQ0+TP9Eqz+QYY
         Y2pQ==
X-Gm-Message-State: AGi0PubEyJSpv8PvA93JgQM1Dp5ck9rXV4NDNdxfWlYg63v8ZrlzQwWb
        csxoR5jo5O9PhBDLYKVXNG4561Vvn8w=
X-Google-Smtp-Source: APiQypIT6Um843Wv0I+I97/IXP+VAsWoBsfQzarxOzaleO4uesJyH+iJVwTLIi+loYTKO1Yl6CwO+Q==
X-Received: by 2002:a19:b10:: with SMTP id 16mr7503029lfl.133.1587758620833;
        Fri, 24 Apr 2020 13:03:40 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id t81sm5153357lff.52.2020.04.24.13.03.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 13:03:40 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id a21so8378226ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:03:39 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr5154247ljj.265.1587758619521;
 Fri, 24 Apr 2020 13:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <156f8353-5841-39ad-3bc2-af9cadac3c71@kernel.dk>
In-Reply-To: <156f8353-5841-39ad-3bc2-af9cadac3c71@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Apr 2020 13:03:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibcCGvPy=PjevdSzEtzrYPWJnLo+t=S3zy3AQ5+NNeEg@mail.gmail.com>
Message-ID: <CAHk-=wibcCGvPy=PjevdSzEtzrYPWJnLo+t=S3zy3AQ5+NNeEg@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring fix for 5.7-rc3
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 11:03 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Single fixup for a change that went into -rc2, please pull.

I'd like to point out that this was exactly the code that I pointed to
as being badly written and hard to understand:

 "That whole apoll thing is disgusting.

  I cannot convince myself it is right. How do you convince yourself?"

And you at that time claimed it was all fairly simple and clear.

I repeat: that whole apoll thing is disgusting. It wasn't simple and
clear and only a few obvious cases that had issues.

In fact, now it's even less clear, with an even more complicated check
for when to restore things,

I think that whole approach needs re-thinking. Is the union really worth it?

Can you guarantee and explain why _this_ time it is right?

                Linus
