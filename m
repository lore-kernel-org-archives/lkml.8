Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CA5C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C8C20757
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6ZRYgVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgC3NIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:08:13 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:34649 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbgC3NIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:08:12 -0400
Received: by mail-pg1-f181.google.com with SMTP id l14so1495444pgb.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxGupKjTBTxMmjXS/p5RBLd4+B0kWJifNxbTQMscomU=;
        b=L6ZRYgVp2RdL9R1roU7nJyxp+033aCT3WVeBHckwbpQLI6Nn5rovdCl9n8pkoZhBAw
         bjbxMx7NoBr7VqDEUdfFIjXlIwEiEZVOV6+szADfE8UgIcmj7KXYdYcT9B1HfNUnSLt6
         MH0D+membhpQdwJvjPC4FPkuHvLKYPdumYeCBsOO30JDbkgaJt5wSasJp2zRW8y7hf6n
         4cdleCOBhrvTAWTNeurBjbDBXveRS5XKmMo84RxAih5qY1EHeitr3orQPbziKDqAtV12
         rglz0ZMYR3hNOTjBRoUlbQZK20Rk8fcUtaSGTlUPDFPJs1T9Ob2v5TOnp5/dszXmpS8f
         tMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxGupKjTBTxMmjXS/p5RBLd4+B0kWJifNxbTQMscomU=;
        b=nIg3TLPW/0ORZN9SfxItf6xTBRz0VoYbE5VdijBALbF7Om+f+Cs2w28rsOLP0W7eCD
         P5C+Z76hwfH0+hiiDxgv1Qs1nXDOOnrGQ3E8RjXui6Vs2jVd6dWM0bL+3Og4geisd9lc
         GDvjTu/Nw3CV25kMHO8jmU+cGk9amv7GMqsEWMqglRh72JlNwgezXTrMe9CP6AZj5mSO
         X2XmG5hTh4ZUPjlX5p5d0PJXB9ZHhHE2adajcGazpV6BM4LJKdiy3BWLtbOKDVSO2fgr
         tY4k5fAO6WwCmcVjjSmoONBX93ITC63ehuy6/KdW6SDEqCvbUMIFlnwaHuzBAUS8dnnR
         7HpA==
X-Gm-Message-State: ANhLgQ0CBAA06R9UMzEte0wwr5YBPYb+fel9gwGu7WawEupFz74NDZho
        RZgdcyDCocGiMNSdvm75HN8qdv+wqzihyYXelDIZbt96INM=
X-Google-Smtp-Source: ADFU+vuT6ZjyMkzZ8ai+s1Q9qdjum+R65lEduCLivXt6mEkBsuBcKgKRr9iM4gLTOoHo4iPYoSHOv80X6GEGbTg3ZiQ=
X-Received: by 2002:aa7:9097:: with SMTP id i23mr12585263pfa.170.1585573690267;
 Mon, 30 Mar 2020 06:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200330085854.19774-1-geert@linux-m68k.org>
In-Reply-To: <20200330085854.19774-1-geert@linux-m68k.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Mar 2020 16:08:03 +0300
Message-ID: <CAHp75Vc1gW2FnRpTNm6uu4gY3bSmccSkCFkAKqYraLincK29yA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.6
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 12:00 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Below is the list of build error/warning regressions/improvements in
> v5.6[1] compared to v5.5[2].


>   + /kisskb/src/include/linux/dev_printk.h: warning: format '%zu' expects argument of type 'size_t', but argument 8 has type 'unsigned int' [-Wformat=]:  => 232:23

This is interesting... I checked all dev_WARN_ONCE() and didn't find an issue.

-- 
With Best Regards,
Andy Shevchenko
