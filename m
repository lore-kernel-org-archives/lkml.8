Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14186C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E045D206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlqHIML7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgESTD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:03:57 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5FBC08C5C0;
        Tue, 19 May 2020 12:03:57 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s21so265927ejd.2;
        Tue, 19 May 2020 12:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWnh3Y0cvz0YAKTVuUXngQ0iqK3p/t0KQcya+B0GLsU=;
        b=QlqHIML7NZVvRAtAKAB5fBsI55IWzMQrniWV/wTiDLMMk9AJ9vgU0WC1CYurLjs0KC
         TrUwCd2JR7cDEgy/YluwmkIzW5h6B1+4Gq6RSMamNupICdIwqNO3KiX1c7WtBMNzQkKf
         eM6zRBe026n40mzOokm+nCROEK+tadDCL2macf+tQQLXrl/avW95Zf45GYJbweJ5j/dS
         aE9ZST9ooRLddeMVq0niI8CXohdIbO9/zYgAMRXfKDnqTNWhOg9/4o8WOb2hNTdhcy7Y
         tmrynuv80VZupWlMXdKAuY624Ftb6LIqhhVXwTOhHotqlLXGheCGRHq0qTevvFwWXa3F
         Fvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWnh3Y0cvz0YAKTVuUXngQ0iqK3p/t0KQcya+B0GLsU=;
        b=ZxoKbur7fWzPhnXQuITat/ERWX+69eqKUnaeg83YEhcuqUJtRPhpGZeiLgc4N2o1fV
         jE35TDWs2/hCOUHe8nwkkaDh9z0nV6vMfbfEMlqK90fJe/LpX2X37nmSnG8oaHylFGdq
         ot76UaxpaTCoQUA89e4R48zCRnWiJMupzAFZVl5Ttl4lhSkxlJlDnJx2W5uyJTF0Mjwl
         YYG7hpXRfx5z/ujGh+ehYAoTtvn1XIlK62PLiMxu+TgK8w26Hs5qxCAW9jwgMEB2xDqe
         KlXgRSZXk/J7rRKgtl3/NeqhgAX7pfw+rhOU7eDEGrrGPicUpXu6jcuZeA8VdSZ+Wm6b
         pH/w==
X-Gm-Message-State: AOAM530RTEywBGIo9e8aIS2AY5t7n39VphC+MRyJKxiCG9Z5JFx4fKAz
        rOlRf0IKpEGZq/eBj8yl062Txgp/3YDz1yoQoaM=
X-Google-Smtp-Source: ABdhPJxTFHlYGTafiBsxGCP3CMKRrW2KSoj8pqEqj5gnGS3v6wPnpBVr+AOA5c/wSmg79TJC63PprGhG4e//Cg3dCtU=
X-Received: by 2002:a17:906:4e87:: with SMTP id v7mr605228eju.384.1589915035572;
 Tue, 19 May 2020 12:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
 <1589912368-480-8-git-send-email-amittomer25@gmail.com> <20200519183345.GA434412@bogus>
In-Reply-To: <20200519183345.GA434412@bogus>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Wed, 20 May 2020 00:33:18 +0530
Message-ID: <CABHD4K9Y2cWNAMdHyUvbkbZrwzLzmug2bm-j+929xv3TgrxVWw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] dt-bindings: reset: s700: Add binding constants
 for mmc
To:     Rob Herring <robh@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 20, 2020 at 12:03 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, May 19, 2020 at 11:49:25PM +0530, Amit Singh Tomar wrote:
> > This commit adds device tree binding reset constants for mmc controller
> > present on Actions S700 Soc.
> >
> > Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> > ---
> > Changes since v1:
> >       * No change.
> > Changes since RFC:
> >         * added Rob's acked-by tag
>
> And dropped??

Sorry, I just forgot to add it.

Thanks
-Amit
