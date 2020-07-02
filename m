Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD2CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956EA2082F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ3i4lz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgGBArB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGBArA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 20:47:00 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D75C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 17:47:00 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 80so24124270qko.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 17:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=QkFpAqHIEwjnDZzlaTT8UYrxvp33BFcnJrcQL30nIPA=;
        b=UZ3i4lz4YGIqh8LxR98d8rkht9xMQ0quD9UlveG9LZH2vjLD9qj3oSfRuxQwi6SgW7
         7KjIBPlRzgQVKjuRbeNPX/dSjtoRbW+wR3qT+me1d1SKHMec7LFbkT/nwJurndd8wtFx
         h0wvGYiX3LSAhqfKBXk7+Xk7a5fEYYAiZrzY3XwmyBtM0RuCPU7B2ir2r1gn6Iwa+gAn
         Xz8woox1ZNCq0tr25hZygYEW1QHbGoSF07QYS0GBCZKXt98E8b53isIUMePGv3wuyrcw
         mlQwAPuiu7B/VH2K/rnFVDFq9P/xaMWdWLPTfrqCF6EX2XOV2n2XoVZfjVNEnEQcZ6iq
         SIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=QkFpAqHIEwjnDZzlaTT8UYrxvp33BFcnJrcQL30nIPA=;
        b=oM7ggOqeRh4f6vycMdBxn47vMoPbFCgSFDz0BUJ/eOG7aCT6xaqxwNEfmF4Pudq41t
         bUvyZMhkmywO6Plybti9HneZPGgTYLhleA4vw5RlFulfGRff1ziQug92i+yDScxzWOz6
         zVZGtLe5sPBV2DxTSY3Hf6CkCcnady4p9VCsPMQHA0qsh7q2vXhiahPc7moL3/lhH0pz
         k05LTAqWMd0DpItA9kMld5A11qhBTNv58OtMdz5RIGKPAoMQcmN8grwkFMO6OxF7Ow3L
         K5vZ25eXS1zkXVMDlKN16xD0B4r3yVEZnKZcmzhGGBs3FuZMTGm7MFMm7a/X2Pk3biFw
         2i0g==
X-Gm-Message-State: AOAM53369cvjyrigZ4tsX+NN5xj6SKYPw5KJPB+m6Odtky6/AotfQc7w
        80/i01olRXUefTzEDS0IWqw=
X-Google-Smtp-Source: ABdhPJwM0hUcN8GwxMqMSwDdQ+uVuPc9qd1xHZ8avHfJ4mP4hIDMt0ZTFiItRktTT17lKMzeGATKWA==
X-Received: by 2002:a37:b206:: with SMTP id b6mr28062822qkf.22.1593650819671;
        Wed, 01 Jul 2020 17:46:59 -0700 (PDT)
Received: from LeoBras (200-236-245-17.dynamic.desktop.com.br. [200.236.245.17])
        by smtp.gmail.com with ESMTPSA id q32sm7306960qte.31.2020.07.01.17.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 17:46:59 -0700 (PDT)
Message-ID: <6ed28aedbad029f107721e2ea4701e5b05233dd9.camel@gmail.com>
Subject: Re: [PATCH v2 1/6] powerpc/pseries/iommu: Create defines for
 operations in ibm,ddw-applicable
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Jul 2020 21:46:54 -0300
In-Reply-To: <0d3ee444-f528-673e-48f9-633138398543@ozlabs.ru>
References: <20200624062411.367796-1-leobras.c@gmail.com>
         <20200624062411.367796-2-leobras.c@gmail.com>
         <b0caaaa0-14c9-51de-bb92-5be8ccaa418d@ozlabs.ru>
         <01443a2f1d58a595ddff03fd14fd56f4c26171bf.camel@gmail.com>
         <a884da45-7778-95cf-d65b-a6c82d2024a7@ozlabs.ru>
         <f1f0563dae4c81620b53bcc258f2960a7948a583.camel@gmail.com>
         <0d3ee444-f528-673e-48f9-633138398543@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-02 at 10:43 +1000, Alexey Kardashevskiy wrote:
> > Or should one stick to #define in this case?
> 
> imho a matter of taste but after some grepping it feels like #define is
> mostly used which does not mean it is a good idea. Keep it enum and see
> if it passed mpe's filter :)

Good idea :)

Thanks !

