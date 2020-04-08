Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1815AC2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BB620730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586307905;
	bh=c4ks+Nq7SBCCzI+OHs87BCC1SHkcSFFdCDnf+LkgP6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ERoZOyofO7GNgTBP+GeZQ+15uIWyHSitnlJSLcOJY0oo8sSZt0lJrfS0yhdj2vDAY
	 uRmCEEXA+WKjKSyTptK52zm2YhKaQtKcXpSeZoIAo4W1AHdMEEJHfXlPy7KP24ypDR
	 eKUZUHRE7PhtNfBAsc/V01RrMAELfC14EZwuwgvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDHBFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:05:04 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:22140 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDHBFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 21:05:04 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 03814ssS012762
        for <linux-kernel@vger.kernel.org>; Wed, 8 Apr 2020 10:04:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 03814ssS012762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1586307895;
        bh=K1ahK7KKPAWpnyfo6tKLdqUOzGSQ4ynuiO6mTIEgKQ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xfM4WxDdbE+mdW0CaIS+gd2ZbYmFucAapXTC13fDsLiVDpbUCFVKjfwpdp25VrZA2
         BphtrzKpvCJfQoxECqKSWDN7GbqS1NAf7gdGnX7pdN2pqnCr/BYwjfERwPKyZ4FlCa
         3LCofOzn1TjknXKrajv/hE9LPwdQcmLYBJEEUX1ZejDIz7/aI9XQBve3YMemlSxplW
         V0Obk3hknfEUSNB1BwOpAQFmMEMqY0xmfhaHe7jfeNmdKjX8x2m70UK6Ub8XPJxB9E
         y/dNntd9VVakbkUpqw+ANc8clGEf2u9iiLmAP3JyFowxxLuXa1Db+K+8xA19U4Howh
         wYVSN/LwPjn/w==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id m15so2105986uao.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 18:04:55 -0700 (PDT)
X-Gm-Message-State: AGi0Pub/toztBdP7e7EB8jhKUl/TiGrt4sPvt5ukvEURamkfsn1YmnAw
        XOwoJkEJQ9rQvlj2yWY2n0o3I+75lmNIzc/kirc=
X-Google-Smtp-Source: APiQypJ/1Y52JCT2NNiYaNpdMWLocsKv2dqcgX0fH+uxTsLbl542WtCzjMOZgzxidv3Bb1sRcVnzKS3X0VN/6cZl96I=
X-Received: by 2002:ab0:20d6:: with SMTP id z22mr3944313ual.121.1586307894272;
 Tue, 07 Apr 2020 18:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200407161933.10874-1-Eugeniy.Paltsev@synopsys.com> <CY4PR1201MB01366A09C22161ED4B30CE17DEC30@CY4PR1201MB0136.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB01366A09C22161ED4B30CE17DEC30@CY4PR1201MB0136.namprd12.prod.outlook.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 8 Apr 2020 10:04:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAROwYx0tTR+euFcHCihbmEht6angCW_J0EZgSFvop5Fxw@mail.gmail.com>
Message-ID: <CAK7LNAROwYx0tTR+euFcHCihbmEht6angCW_J0EZgSFvop5Fxw@mail.gmail.com>
Subject: Re: [PATCH] ARC: [plat-hsdk]: fix USB regression
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 1:22 AM Eugeniy Paltsev
<Eugeniy.Paltsev@synopsys.com> wrote:
>
> Hi Masahiro,
>
> I'm wondering what is proper way to deal with such type of regressions?
> Is is responsibility of person who change kconfig to check (and possibly adjust) affected defconfigs?


I think the patch submitter should take care of
affected defconfigs when (s)he drops select/imply.
Also, this kind of mistake should be caught
in the review process.



-- 
Best Regards
Masahiro Yamada
