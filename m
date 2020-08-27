Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD31C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F3C2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB9WcXqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgH0RRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0RRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:17:21 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39DFC061264;
        Thu, 27 Aug 2020 10:17:20 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c8so5595195edn.8;
        Thu, 27 Aug 2020 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rMb9LJxrcGiTyNyXwwyZ6syio89Yz2hnJzYevmI52VE=;
        b=dB9WcXqWXys8obmbtsB0NyXuam4s3n3sqAJ2FO6MZJziZgF/U2ynJXCnc9PrqpC5lz
         btmeqnTmPPM68itNNSwrCzFE0WnEs1uvNCT8xwHVWmboUN09RG6elHINBAOcw3iqNTa1
         n2IyTmgJeFz/2cRfLv1X9kY/jnySuyrnFe4ani1nQ2Cob+Ksaky6eWsAb7mfnN6kbTLv
         76Tj9XOg2XfiNGpT0y61jIITf20G9IwvOcUKhDQ+mVtQbgcxrx8Ivb4zli+1UqJ1tlxN
         fVuQo1vgNqeA2yCN5zQo0tOx1qmSFcQZRKDAewJTcchnXH4rI3r37SbDhXgs/cSGGYr0
         BGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rMb9LJxrcGiTyNyXwwyZ6syio89Yz2hnJzYevmI52VE=;
        b=pmGylB5IH3qV90drfTtjSzlU17+tec8ZYy3Mx1hWqdZpqZ+T0LAYRvSB1yl0J66+z9
         WVZqVi8oBxYBAZs+fRfF0b2jy0zROvny73jaYDVUBcew6hTUp+47CwXSwCXyQIBojiiL
         /yurd7B2n116huy90g3JPVIaAE4pmdXSQbgv0cZK8mgxWVj2wZLynRoSaQk4bzDQX2VO
         BGH/ItO7nO8fbxwcgu4IlF9FEr00OsGwTs9vLo5C2tTHH0/t16kfEzOrm8RfQ6G5qTfH
         ne2HptaaQNlzFCXexnTN4n7d5ep7YGejwhDmLjmmiF1HaQjUC5CVGNTPMljJX9YI6svs
         9WwQ==
X-Gm-Message-State: AOAM533uO6w/CzbUn+RLL5YgJIQlhG2jliip0+s5biibn/uBxP+aJ3Uu
        2QAmeKiH1CRjTZQHxgIKzk0=
X-Google-Smtp-Source: ABdhPJwcBvHTnG9Xg7kXrNUUX+KbvFG59tNLBgd8D/deEo5TMVFE72bHs1NgF1Ey6p8ITpDfcQmxLQ==
X-Received: by 2002:aa7:c596:: with SMTP id g22mr21145561edq.109.1598548639333;
        Thu, 27 Aug 2020 10:17:19 -0700 (PDT)
Received: from dell.be.48ers.dk (d51A5BC31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id v13sm2336389ejq.59.2020.08.27.10.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 10:17:18 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.92)
        (envelope-from <peter@korsgaard.com>)
        id 1kBLWX-0007qi-IQ; Thu, 27 Aug 2020 19:17:17 +0200
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
        <87v9h4y4dj.fsf@dell.be.48ers.dk>
        <20200827141520.GD2451538@BV030612LT>
Date:   Thu, 27 Aug 2020 19:17:17 +0200
In-Reply-To: <20200827141520.GD2451538@BV030612LT> (Cristian Ciocaltea's
        message of "Thu, 27 Aug 2020 17:15:20 +0300")
Message-ID: <87r1rsxb36.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Cristian" == Cristian Ciocaltea <cristian.ciocaltea@gmail.com> writes:

 > Hi Peter,
 > Thanks for the review!

 > On Thu, Aug 27, 2020 at 08:44:40AM +0200, Peter Korsgaard wrote:
 >> >>>>> "Cristian" == Cristian Ciocaltea <cristian.ciocaltea@gmail.com> writes:
 >> 
 >> > Add a Device Tree for the RoseapplePi SBC.
 >> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
 >> 
 >> Reviewed-by: Peter Korsgaard <peter@korsgaard.com>
 >> 
 >> On a related note: There is now an owl-mmc driver for the s900. From a
 >> quick look at the datasheet it looks compatible with the controller on
 >> the s500. Did you have a look at hooking that up?

 > Yes, please see:
 > https://lore.kernel.org/lkml/cover.1593124368.git.cristian.ciocaltea@gmail.com/

 > The clock related patches have been already applied to v5.9 and
 > hopefully the pinctrl driver will follow in v5.10.

Cool, I must have missed that series Great, thanks!

-- 
Bye, Peter Korsgaard
