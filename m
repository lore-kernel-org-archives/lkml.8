Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2F8C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE19A20753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i33YDFJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgDIRda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:33:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34077 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgDIRda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:33:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id m8so576279lji.1;
        Thu, 09 Apr 2020 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w6oua6pgdDdSLqZ3ElhE13JK0x2D0ixah/qXhh6Ol1s=;
        b=i33YDFJbxAY1klyUDrn2OSxE4UVt9CzORk36sK2BG/j0PsNrBCtaMIKE+7iaPewQJt
         PB4k7YFlnp7LTU0Rl9P9t+XEqXnQOuOK3m0fcKC7UBGcPKwDOD2KC7fYfGqZrpQqiLVH
         4P4KUpeLgqtjuHbmkH1Kol4U6zu3/EtBcC+1xPcqiPY7gAU5/trfH4HZPStaH44Q8Ocj
         YEDus66YJHWajYVDdHMSFW9zbAIi2/Ih9Q/AfLeqB6LGr/sWvSfOxRmv0X6c+6qh/n6u
         Lt6BEuRkvBkEuU51VvtT34BKIta0ENM9TVh1jIjqxGeuypqu1VvVIaS6iPU0pIOy2M2U
         Es3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w6oua6pgdDdSLqZ3ElhE13JK0x2D0ixah/qXhh6Ol1s=;
        b=cdFW6oFBlGdCv1dN9alY+IrfSrbqlUmw89QuS8CtIoPz7aux/oTyxpsATBvuv4xTqb
         GypLhejf51UX7khElaHEM0DFF3njAaky3KDK5mZ3ej90XJ0sI1rMm39wAeS+0kcyr5Ii
         H1iHaEBeWKuYwlUzUPNfI/Mw5b0SvkYOIMeDiWqhf7VdooPi9fA/WEUjlWOX2EiejgWf
         E/sE8vI/Yu/8vEFZl9KRsmGe6PPIcmQo8lCyZSeLUF3Ad0htfUNbxqcUgpYjDQBef7VL
         pT8zMtDwR05si/+w85djwqPefODNwuYZgEj0A+49zWy9zqdhkNUQTbX0/2BQ00Q/hu4u
         SGlA==
X-Gm-Message-State: AGi0PuboZrUPPeWABNrd2orsI4ouRqBUgGzJNaGc9h03oFNj5pNwTyov
        nAW4NAKtD+lSFfBPjNKQ1Xv1z9Vn
X-Google-Smtp-Source: APiQypIFKzX2orBYpj3ZpvYChLybojahKGx4VgxULoLxhE1PIkc77vnIGEr1STj82ZoZhDpkUZ+Vhg==
X-Received: by 2002:a2e:9757:: with SMTP id f23mr513176ljj.269.1586453606298;
        Thu, 09 Apr 2020 10:33:26 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id y25sm10535877lfy.59.2020.04.09.10.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 10:33:25 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] Support headset on Tegra boards that use WM8903
To:     Mark Brown <broonie@kernel.org>
Cc:     Stephen Warren <swarren@wwwdotorg.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200330204011.18465-1-digetx@gmail.com>
 <5c9c995a-a571-e543-e680-30739cb1561c@gmail.com>
 <848cc6c5-e8e4-2796-3ee1-3e12a3e92c54@wwwdotorg.org>
 <a7159a8e-4987-0c08-ce3a-fa82d926218e@gmail.com>
 <20200409172952.GG5399@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0a82ccac-7a4c-ca0c-9a88-3a77c7bc24e6@gmail.com>
Date:   Thu, 9 Apr 2020 20:33:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200409172952.GG5399@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.04.2020 20:29, Mark Brown пишет:
> On Thu, Apr 09, 2020 at 08:13:54PM +0300, Dmitry Osipenko wrote:
> 
>> The code change doesn't affect any of the old users, so it should be
>> safe anyways.
> 
>> I understand that you don't feel comfortable to give an ACK if you're
>> unsure, but I assume that Jon is in the same position, and thus, I'm not
>> sure how to move forward.
> 
>> Mark, could you please help with reviewing this series?
> 
> It is currently the merge window.  Nothing other than bug fixes is going
> to get applied until the merge window is over, probably Sunday or Monday.
> 

Will be awesome, thank you :)
