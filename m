Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76F4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 05:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93CC320829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 05:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SROeIPRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgGaFJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 01:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgGaFI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 01:08:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085E9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 22:08:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ha11so6694727pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 22:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JHjIJTBJBTgUWoslHF7PITJJr5gm4KM0Yh2llRAmHQU=;
        b=SROeIPRYWuOnttEmX05+rUyOwgaBjAo/4WwbGvMOPdK9En4nNdSbjr7Aj7OYhpiByS
         +tne3VyOxlKLzhTu9d7x3C+PxsmmscHTGn4byZX/vrjmt3sni6L81/0keQmIM2LtI/m+
         IeqsOOSzWmI0pCrnM9djRCVez04i42STL8jcGUhis4CkvhGND4sk+6M6trR2mUsm6knB
         MawipyNHqeN+/dYHSQfA7EMptSfKqgSZVkGR1X4JYrHDCjkboQ7oMWb+75jg9S16H8Es
         V4vYJGvbKsXWyB8TUkJ6jvWdEUFuFag28As6LS5CmDbHWunVopjADRG4uk3qSt8HiFaL
         zJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JHjIJTBJBTgUWoslHF7PITJJr5gm4KM0Yh2llRAmHQU=;
        b=ir6Ob0PMsUvPVnNLtb/c5XJzZ5rDH8M9YRxUSNg0fsnQkERQVjUzhaLWajzIUpkPE+
         tPH1dNBwhIKsKibcu9lcB4fShYcEaU7Gsi63RRrPYgP1eb3mj6LmRRn1xpwU0SUza8us
         qbevleHkduLtCFyyZsyGHJ+44l3QMv9DiJQ9exNLlYLGfJL6gqE4y+TG6K6/YTV2kaKd
         X4rFtUuPfmDtZuQoU7kjezL7NGgYADz542qhW17M+b6bAwbQumzLUIFPJbaz5tLu5tOr
         EwLhHJxUcBjyMt8jtig2BPOM7U2d6yeYUu8RiZLmKnHM/WkjsdehlVKYovbxiEbbiMos
         naeQ==
X-Gm-Message-State: AOAM532SW6Xa7iN3y4bIRGs4dTzrGJmXZZK/wNGgbNnwj0Tv4XDX7y2j
        ce8h7WQs39A9hitOUwIV9V4=
X-Google-Smtp-Source: ABdhPJy7Oz3Df3DzUKcdAS+mro7JR56UBRqdXPWb3W3RXItZnZmuX3YFJA1+9iWxhbH/q3+TlAsvhg==
X-Received: by 2002:a63:3681:: with SMTP id d123mr2155531pga.317.1596172138333;
        Thu, 30 Jul 2020 22:08:58 -0700 (PDT)
Received: from gmail.com ([192.55.55.41])
        by smtp.gmail.com with ESMTPSA id r4sm7227679pji.37.2020.07.30.22.08.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jul 2020 22:08:57 -0700 (PDT)
Date:   Fri, 31 Jul 2020 10:38:52 +0530
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        greybus-dev@lists.linaro.org,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: issue with uninitialized value used in a comparison in
 gbcodec_mixer_dapm_ctl_put
Message-ID: <20200731050850.GA25458@gmail.com>
References: <7da6363c-9423-2b9f-029a-395cc8a932d7@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7da6363c-9423-2b9f-029a-395cc8a932d7@canonical.com>
User-Agent: Mutt/1.10.1+3 (f9293d646485) (2018-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 05:02:22PM +0100, Colin Ian King wrote:
> Hi,
> 
> Static analysis with Coverity has detected an uninitialized value being
> used in a comparison.  The error was detected on a recent change to
> drivers/staging/greybus/audio_topology.c however the issue actually
> dates back to the original commit:

Thanks Colin for reporting the issue. I'll fix the same and share a 
patch soon.

--
Regards,
Vaibhav
