Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6116EC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ED32073D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLVQDXo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAMHB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:01:57 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34121 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgAMHB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 02:01:56 -0500
Received: by mail-io1-f68.google.com with SMTP id z193so8690782iof.1;
        Sun, 12 Jan 2020 23:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsbDRNDzst0FCtsqjfZvoh3SmvfRwKfaGKtf0fe77Cg=;
        b=hLVQDXo+f/4m+HPEpUBTCuRm5kEY0TbHBcB440yq8M2l8WzJbQ+bgwnaXrRDUomiaF
         Q4O0KpINremcEoF5CKoTPyppT9U8DJWHqGh1HowO2YfQcZThUGaSzrhAkjoXfmm983dy
         AOwhmuaSQ1STiWtf1SXa01NQJDj59gd0wVqM8e2iiHzbNEiSybD7aEAKv6EjMYePDefc
         wSxiFfT5fR4AVSAJUJ/ZUXh3ujsj9veaQJuPTyknX2zT3Bdj8zO2HFTK7FFhjVWgR7rP
         B3eyBW3VKw9UohnPlnDSnpjIOd636ecF0/U5gyFwpruZKHgDuigqJUcPiWtIhGtN8Dus
         2qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsbDRNDzst0FCtsqjfZvoh3SmvfRwKfaGKtf0fe77Cg=;
        b=b3FA9Wdy4wP/GbCsw0OllnRj0nQZrYB9RmBlobAvk4KIfoeN0Ma+IsmKBWcEtAs8IX
         r0dqK1AaC7fMUtG8uMO3Dc1evIoHKjGzX4iElJ81UHCtdD3W7BlvF9hg0XJCwgcgE2jM
         Icjwacan5kxUbBOjQR8bS4t/MyLq05xZ/ZsFO3Tfjhbhfh1jdM9mU4eBy3ewx37K7C5/
         z+sRBj5JJ4kDSjOLkZfDAh0mNl7RlO++yvCUEvXsaA8GJkyiYSneHtc/76GQyfO0COCe
         f6cxvmbqa+jne+96Ilya31xgHaefJWYh+k/JwI6psIAS4XaAgRVQALo62cItScD3nwph
         E+wA==
X-Gm-Message-State: APjAAAW1SU405AmOwVpRApSmCY7t6TpVMUohO0H9l4R7lEWJCzoGcUZz
        0h7WOIK3qD/n3M7/scfkZay4KhWLfdCrg/ZToXu34K/i
X-Google-Smtp-Source: APXvYqzGYNzwerPDVXJt98iCwKwkWXo73GvAPltHNbIX2803TWfkhayXO1co9EjWgWenJpGusF3nvl9YaWD/LCBEU9M=
X-Received: by 2002:a05:6602:25d3:: with SMTP id d19mr11146853iop.217.1578898916004;
 Sun, 12 Jan 2020 23:01:56 -0800 (PST)
MIME-Version: 1.0
References: <20200113035917.1419452-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200113035917.1419452-1-srinivas.pandruvada@linux.intel.com>
From:   Yu Chen <yu.chen.surf@gmail.com>
Date:   Mon, 13 Jan 2020 15:00:38 +0800
Message-ID: <CADjb_WQkq0R8eCNvZgtjytc3dcn9_65pzCt9brYZHo6ATy5wuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/x86: Add support for Uncore frequency control
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     andy@infradead.org, dvhart@infradead.org,
        Len Brown <lenb@kernel.org>, andy@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,
On Mon, Jan 13, 2020 at 11:59 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> +
> +/* Common function to set min/max ratios to be used by sysfs callbacks */
> +static int uncore_write_ratio(struct uncore_data *data, unsigned int input,
> +                             int set_max)
> +{
> +       int ret;
> +       u64 cap;
> +
> +       mutex_lock(&uncore_lock);
> +
> +       input /= UNCORE_FREQ_KHZ_MULTIPLIER;
> +       if (!input || input > 0x7F) {
> +               ret = -EINVAL;
> +               goto finish_write;
> +       }
> +
> +       rdmsrl(MSR_UNCORE_RATIO_LIMIT, cap);
Should it be rdmsrl_on_cpu()?

Thanks,
Chenyu
