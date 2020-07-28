Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A517DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78EC3206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595935183;
	bh=5RH0evsGheZpTl6xa5jfSdnFyT8Qy0EnSAVYoY7NRSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OooCkX9Zo20C/53epALcTHfTkSRCXYYkkqNOhbln5X271IHv58t1YK0zVagdIjeoj
	 yiGZND84q6/1EinSc3Qrv0w51XjABhzuSpInLqSZGvlxauqidFE98NsfNGd+vBPj1F
	 /nCiRQHckV3dtEQ7juC73tZRp/BWEo+/MC6qv/y4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgG1LTm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:19:42 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:46496 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgG1LTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:19:41 -0400
Received: by mail-ej1-f66.google.com with SMTP id l4so20189929ejd.13;
        Tue, 28 Jul 2020 04:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dM5eSEIkgFsWm5/PXwhPw6+TPBfgiyZycrwo5NO8ZdA=;
        b=OVhLEfy/je3Ry4pId7FoOP4r3bmoN0oYXN/iCFbvvpKBRlr14GhLY5tveJlfOr9hz9
         D6o09KRJL5wh9fN9GcIdGUO5sViefshAaJ4Wxe9t7CMB8lX0Hrbfq2M/QFgm2g9qgbYV
         8euVt0QdJ4lSY5uqWf7wCq4+S25XGmJhbhCjdYhJZ+9ss6p+xt9kzFrsaFmqi1iEhAjT
         qTRliTY54rgQE+0a0SBAZaa+H1aGde3xEmOWtDxIQN1PyyURa+5r8ekY479+MPEv0Ojw
         46/ZDTIJLJSacctsfxxOPTkyrfWKbmusR/FnIGyay69TayMFqIe5I6patuNU9IbHXWV/
         qUSw==
X-Gm-Message-State: AOAM533Hyh8ae1G68bwq3SpQVcOAbE9e2PVJJMeZ/N5aybg2yVnJ1kLE
        joH9yl/zNHrQF1l9kf2FR/s=
X-Google-Smtp-Source: ABdhPJyz2/TikQUdItm0+uq4RKPRKwe4oJHmYss6SVmNZp8hFZcshbLBoejJ8XshmK75eH6Zzjxqaw==
X-Received: by 2002:a17:906:b352:: with SMTP id cd18mr620105ejb.230.1595935178942;
        Tue, 28 Jul 2020 04:19:38 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id h24sm8878994ejg.53.2020.07.28.04.19.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jul 2020 04:19:38 -0700 (PDT)
Date:   Tue, 28 Jul 2020 13:19:35 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 2/2] MIPS: ingenic: Enable JZ4780_NEMC manually
Message-ID: <20200728111935.GA26683@kozik-lap>
References: <20200728104503.23655-1-krzk@kernel.org>
 <20200728104503.23655-2-krzk@kernel.org>
 <B4F6EQ.WB2WZOY40FDR@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <B4F6EQ.WB2WZOY40FDR@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 01:12:11PM +0200, Paul Cercueil wrote:
> Hi Krzysztof,
> 
> Le mar. 28 juil. 2020 à 12:45, Krzysztof Kozlowski <krzk@kernel.org> a écrit
> :
> > The CONFIG_JZ4780_NEMC was previously a default on MIPS but now it has
> > to be enabled manually.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> I think you should swap the two so that there are no problems when
> bisecting.

Good point. I was thinking that it will go via some of MIPS trees and
the patch #1 will just wait a cycle.  However with acks, I can take it
through drivers/memory tree.

> 
> With that:
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Thanks,

Best regards,
Krzysztof
