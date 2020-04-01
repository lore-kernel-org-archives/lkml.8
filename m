Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D688C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E744D207FF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hyYhjFz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgDAITu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:19:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39322 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgDAITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:19:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id i20so24804742ljn.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIF2sw8MbXchkPoDVzAgUmxa+aiittUAn6fk84R4bVU=;
        b=hyYhjFz5pvJkCFsukALtuudolp+CuyATl5yvXAICDZGpVAl9VIjhIgDdC6o9D9UvyM
         RzS0B91qEoHpGSCVa3s3b6WQ7yrkwnZ7KKNds7J+qvMfMGi+Jb9ZwiQ18OvSHLiO81kB
         VzJ1BuR48clo5OcFEy5TajcF88cjozr6rFK5ENPEUkPhFoDpvbvSC3D3lvTWZpvSdCe7
         1ZiuyVuMF4cBUQB0WHaz9fGjmyqFwTydm4eO7OWbY+6/tQOHnYvF14Tx/QlBIRa81lhp
         aN5OxoTkdL8q+56CrXPszC9BecU3VxiBreb31qeDyWJM+CX9UbR1ApbdlWzm7AmdewDw
         dxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIF2sw8MbXchkPoDVzAgUmxa+aiittUAn6fk84R4bVU=;
        b=MHqa+sgiJN/3rAO+HG2CFB48LLqZNjtH1gPOAbsnJ5KkGL7wHHWygQO5EUsgijubJh
         rFhQ5xHMo4DL0N8pdtb+xD6ecCaAABFKT5BAtK/GSZI3QyLa+nujSv9cTE1lkTbmq1H7
         /Int7Y7Gb8RbNeACLT4TM45RDNopOHi/5ZtiiLXJP/RlVHXCwUX+bBw/EIjbu25cIzsH
         qoVRDgQtGb01NIDXPr0AxmIvxLnqV7lW8n7Qtt/zO+e6JvMjhpfK3uK9cRNJAd+JIWpk
         Jsd4M8FKOy8dU8KDieRJxGd9f4LJVzibx0c1Yy0tnxLQtKSaT4OBelsL9+FXDw/Rzpf6
         FwAQ==
X-Gm-Message-State: AGi0PuY0NwydztCHFVX8LAZ6Do3kSZiYzLhuG/jWo8zFWgQJmX+wJNTt
        bsCNHgfdRZk4KfnD/vkXmcwHfRkkqIZcRbIUBL+Whw==
X-Google-Smtp-Source: APiQypJaZ7pJ0PA0qD/U/Bus/fhNXfVe8twCFP9intjOR98Q3Ir5o2KVftwuOvWKnZAVhs3KAWevTf53y4RxCtSNUsk=
X-Received: by 2002:a2e:9605:: with SMTP id v5mr12032411ljh.258.1585729187241;
 Wed, 01 Apr 2020 01:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200401151904.6948af20@canb.auug.org.au>
In-Reply-To: <20200401151904.6948af20@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Apr 2020 10:19:36 +0200
Message-ID: <CACRpkdaLByWiDCtgz3Z6Tr1sahEEyAfWvnM8Uqx+ygpjGwmLhg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the gpio tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 6:19 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 1 Apr 2020 15:14:32 +1100
> Subject: [PATCH] gpio: export of_pinctrl_get to modules
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

As noted by Geert I simply applied this to quickly repair
the build. Thanks a lot Stephen!

Yours,
Linus Walleij
