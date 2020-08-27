Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A9BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F2922B47
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eig7GaE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgH0Gos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0Gor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:44:47 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88357C061264;
        Wed, 26 Aug 2020 23:44:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id si26so6120200ejb.12;
        Wed, 26 Aug 2020 23:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5lZlEjBzHRbMaEVBrPh3+beD+zVE1nLzNB1myX762eI=;
        b=Eig7GaE7XdtAk48TplK6uI32yfBA7+SXesz+kHeB7XZmBb+3DwCE5/M3VmSy8sYXWe
         v1NEBt1cRDS4guAOYoKqZGD++lWBO1I8RKYLJ4MRV+HLW65pSYYRkIai7n6xWxTWVVVL
         bnS6fZEu9DbCWXSYGc63CZxyzYKBwttSwLEjIDrMa+NZ8Mp/Qd7CJArFfeL1AJah468N
         i9sxzoJqo3TJSiMAvvswZZyNoGk3tscjSQaACzfGn59u72K1bv0q5h1s/Uu16i5zUI6q
         oXx1ihd5px0RTi3KVHJdAz5ATt7pkSIySTONx/Zi5cvVjA14XZl9g/Zz4p51Zms+zn1b
         aQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5lZlEjBzHRbMaEVBrPh3+beD+zVE1nLzNB1myX762eI=;
        b=TNX3vKLLeqFJj56Xs2CdIl6V2Q+ZY52FIrHLnsRxlg5KCns1YqbR7cJKjy7r1u/Fm7
         RHDPKE9Q+m/wWcNIsuQ+bInRNkSQUe2FURGNvZI/x1K4o4UnCUJA7I1YMPmVytPCrMVl
         cX7cRjyEoxB9twxF55xgkeFM5QnfUjxPako287BVtfJzWXZES3JyFminbXYkhI4ISWUa
         6XoSWFLGnVFfpeEu9rfFsYP7KVDKgRScd24rsuFnm6mbKjKyjSI0icjy5k4UYKq/LD6u
         whMx8smqJCg1HSgIJrYNk7BCSfkA6BKYe3VEQ6VqbYYhbPK/Chnb1NZ5oTYKbj1kwgxg
         iikQ==
X-Gm-Message-State: AOAM5332dEgVAsbNsIjH4PCQXQrBmNtdDwzGXnDgN40WqMyk/ogO1pPi
        nH9tf6j80pcjfq4MQnQDj8I=
X-Google-Smtp-Source: ABdhPJw5t5UbTv14Uj4GGZCXucqEXH1T/j2DVoME59kzRmfLL/U93OuLxcFPSpBov8Bart9NRig9cQ==
X-Received: by 2002:a17:906:d8ca:: with SMTP id re10mr18729543ejb.382.1598510685222;
        Wed, 26 Aug 2020 23:44:45 -0700 (PDT)
Received: from dell.be.48ers.dk (d51A5BC31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id t21sm1048506ejr.62.2020.08.26.23.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 23:44:41 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.92)
        (envelope-from <peter@korsgaard.com>)
        id 1kBBeK-0002mM-CC; Thu, 27 Aug 2020 08:44:40 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] arm: dts: owl-s500: Add RoseapplePi
References: <cover.1592123160.git.cristian.ciocaltea@gmail.com>
        <2d12521d196e2c08a30aacd0ab20d93593f94707.1592123160.git.cristian.ciocaltea@gmail.com>
Date:   Thu, 27 Aug 2020 08:44:40 +0200
In-Reply-To: <2d12521d196e2c08a30aacd0ab20d93593f94707.1592123160.git.cristian.ciocaltea@gmail.com>
        (Cristian Ciocaltea's message of "Mon, 15 Jun 2020 03:19:11 +0300")
Message-ID: <87v9h4y4dj.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Cristian" == Cristian Ciocaltea <cristian.ciocaltea@gmail.com> writes:

 > Add a Device Tree for the RoseapplePi SBC.
 > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Peter Korsgaard <peter@korsgaard.com>

On a related note: There is now an owl-mmc driver for the s900. From a
quick look at the datasheet it looks compatible with the controller on
the s500. Did you have a look at hooking that up?

-- 
Bye, Peter Korsgaard
