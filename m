Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F04C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EF120775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585132730;
	bh=lLPYj3tstQ31DLYlKDDc8Fji8FRm44KGvzvTsDQLLaI=;
	h=Date:From:List-Id:To:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=yZvE8GXDQYYEkzfNwP9yRLEQIxqIqezij+NMCuKETUj5nyaYxc9paeH7K3laq8Vlx
	 3Eu0nNgyGdzAM/daI18BiRp+UTGEn1iUWt1Gm0cm80jwch9RInjE716lX4rQF3KF+U
	 78pzNI6MLAZwE9nCV3OY1gl7kiD2ODxmsER7x/3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgCYKit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:38:49 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:33375 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCYKit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:38:49 -0400
Received: by mail-ed1-f49.google.com with SMTP id z65so1747529ede.0;
        Wed, 25 Mar 2020 03:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rChnKt/buGlg4oMgDuHolFkSTfOBDmB/aUQmKVJ+Bu8=;
        b=HhzmmvPuo5WJNnfepT5Eqp4epSpOdFhdzED5w1oFTf0ml4B6wMvxyaaTFCjlQCKq2Y
         1O1iXBJvBTMtdrp6WvI3UFDr2Y0k3VJ3EO7tcipi6Uw/MFkM3+gxf0i74927eNksgYZW
         ljm+esdiul2QmTNABfQhrsijs5kZ95J5n+5RGbq+Dw1wjwPChmZE57ZwpR58xMcaeT9r
         QQp4F4b4FjR14709P6C4ep0HaWcalAZWpO+qAgBvRAG9sMcJXxzmEi2l/0IODn6IAUrq
         FSYRpIqVHeJaEmehDzmzz+pzJRK9HWnJYsbCLYE3lr5VTT85EdYnTxzgp2oSzQ93Lwun
         TzOw==
X-Gm-Message-State: ANhLgQ01Vk8lmGZR0mROPMGnqBqe+ZSu+zS8VdxOuvYP7bxTPF5AhiH/
        UfWKO2W89JWZuAt928KdQbs=
X-Google-Smtp-Source: ADFU+vu6wOHo0Oo5RedHizV/zMZxQCP2qEaIJff3a9ZAD1Wu4ZYA7zr+gdDKh5A2BskBFG1jRYSWGw==
X-Received: by 2002:aa7:c610:: with SMTP id h16mr2228662edq.348.1585132727057;
        Wed, 25 Mar 2020 03:38:47 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id s7sm1458659edr.15.2020.03.25.03.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Mar 2020 03:38:46 -0700 (PDT)
Date:   Wed, 25 Mar 2020 11:38:43 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
List-Id: <soc.lore.kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 0/3] ARM: exynos: Pull for v5.7
Message-ID: <20200325103843.GA17099@kozik-lap>
References: <20200316175652.5604-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200316175652.5604-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 06:56:49PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> One patch for drivers at the end of these series. I also sent a fixes patch separately.
> 
> As you asked, I updated the Google Docs with Exynos entries.

Hi Arnd and Olof,

Any comments on this pull request?

Best regards,
Krzysztof

