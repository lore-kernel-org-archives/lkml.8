Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B545C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 20:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAA020738
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 20:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSrIKjrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgHBU7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 16:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHBU7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 16:59:01 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2469C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 13:59:01 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id l13so10148569qvt.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 13:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpfNXkmyS/c2cFjwANzmOGpAdi0vE66LKzF6F3Z7eQk=;
        b=aSrIKjrADoVRBEWSh724z0l2SvU7xD65h+yV3/tvRvc4/cmNs2OW8PRyVehHtJpRYV
         4wxc0hi9G4yS6espX3YajJiLDsgaIJc0FlxfPwrNuqKpBD/HVpoQFDyu4ZgdEOdkembk
         r1bZ/WWY8W34j5pRhgOUBfcXI+v51FJ2STU9iKSWU24sMdfHA/r3hu7sE0b67dbsUgtv
         wIL0aAGIrrjEI11byUfwcbPq33IVEPvdQtAcW92QZbv5X4YHqn5AuwCnafgOPZFI4TM1
         Xa/k4Lo1+761rmgR9pkHao0Xcow+NLOLryEQwq9By5y/Gxhd5CSg4gg3dm/U78OCXzwd
         A3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpfNXkmyS/c2cFjwANzmOGpAdi0vE66LKzF6F3Z7eQk=;
        b=Yf0EPjSv4Kz2LJrJ+qOc9Zdv7oNv4POxz21q11Bh1e3/71EG8IBAG6RiS4Q99VdwtO
         Mg01Mpki6xPphJZuVt/Zd1cltfC52ctgUWL/FSoNgQfaMUsVaFpW6nB+QNSu7scp4mM3
         Y8xT6dER2SQUAmP7QciwbqsV5OiwTOET635+kiCRzDiQK3PoowCGDrrLcQpSKAyaC6Uz
         NM23ZStRfO66FGwnh5OKo+Hs31K0ECdwbqWlaq6Ad+mAG1nR64vKNNey9UWjSequZit7
         LdOu80vZnwLuhldnpPrlLnMkYvtji861CszXieWulXLGbgLxxyRfMGS1V6B7bev5UVgm
         MZwQ==
X-Gm-Message-State: AOAM533/y4AdEBYSQDgGkIdGHaE5GkJHglIWhLKiMcEmA0t8tpdqI7ER
        Oec05fX7/cUf+i3TYUOl4SCr+U+sjYFnjnC49QA=
X-Google-Smtp-Source: ABdhPJwX/6WflwM0v1M9O0qKnaq2kmODM4nZjATuNJy2Siy3bLl+GYVf1knPozuS+3wj/X+Eon00Kw1cjB/cV2f2tWU=
X-Received: by 2002:a0c:d60f:: with SMTP id c15mr13951446qvj.17.1596401940674;
 Sun, 02 Aug 2020 13:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200720001444.30972-1-rdunlap@infradead.org>
In-Reply-To: <20200720001444.30972-1-rdunlap@infradead.org>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 2 Aug 2020 22:58:49 +0200
Message-ID: <CAFLxGvwKqQCbO_Rd6nadjwGD3-9HE4j9msOyUk+SuujiEbjN2g@mail.gmail.com>
Subject: Re: [PATCH] ubifs: misc.h: delete a duplicated word
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 2:16 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Drop the repeated word "as" in a comment.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-mtd@lists.infradead.org
> ---
>  fs/ubifs/misc.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied!

-- 
Thanks,
//richard
