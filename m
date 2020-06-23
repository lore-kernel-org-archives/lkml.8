Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACF8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E80F62075A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbwdEUS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbgFWCnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731557AbgFWCnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:43:31 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9DFC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:43:31 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 80so5720565qko.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=kogeuzYaTU35x822P/lH4bJd4mEjWVYLr7oYj41vm0o=;
        b=FbwdEUS3+pvBEN3kjdTEyyToae78/LPr/MS6xOSoYMjtVFDz0LqgWMzSVHwE9xRwE6
         t2cJEA3tFkcLe7Bg0WPowXzPxjBNwPJNtxBEUFpXZ43SqgaHTg8T1TdYMT9aSMs/yA1x
         iW5Rt2EAHdGunKLZRwqS0bJDjB3/oVTt1FouC3SbhagSc68pufilxApKwKjq+vSFKy8U
         oUrSjfWyvoDh7FKb11HAMwFCSxBDMKLfLDHW+Txc79G56N8Bk0Kf1RzrW4ulJQPJrj//
         Sr267BhXc2/nYuapGLoK6nMAmoz/4h1dZE0PYD6JkaTwpeEmSy1CQkbKiRneTipN5cxe
         Yx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=kogeuzYaTU35x822P/lH4bJd4mEjWVYLr7oYj41vm0o=;
        b=UH4zW/EjWAorLb5nOO9YUdN3aQghrSNGPj130Com6XssvNuKlHQVaY/OSAvnRIkB8G
         gHXyFg+RLyLawsLZ4br8q7nZW90yk1vGGSEes76/6annpIuNthA1UyMyWlTtg7i2AUKx
         LwA9VSeZ8onbLY5Af2F8tTFG0AcPEtqu5Dfcrhlca9Kpn1KWIwO+PoL91bg20QiHfxGA
         S5SSHpBzn7K5igCep5jIz/wC7dJj1TEgrsE9oeVy7D8/XhXo3ma8c/D/GZNZcMoF2DMK
         PdaBw9cBtIgNery+Z83e5PrGWsAqv8vs43nNj0hGQxFUOYYetYktN3Iitdvym3aNHOax
         YIJw==
X-Gm-Message-State: AOAM531IBH6XXHtMgKnhARNl831UXmM/CnNOpEeCxbQRjsaP9he7Og16
        jiKeyH9T5qtaZDBIqOvoNR8=
X-Google-Smtp-Source: ABdhPJyqVq577kVGHv0tkWWZY/8JKIkFv8YoUyYcWXpJR9RpKWU/YTGByz8MrLPIpD0Mh8qeFVOAjQ==
X-Received: by 2002:a05:620a:1408:: with SMTP id d8mr18735138qkj.110.1592880211071;
        Mon, 22 Jun 2020 19:43:31 -0700 (PDT)
Received: from LeoBras (177-131-65-187.dynamic.desktop.com.br. [177.131.65.187])
        by smtp.gmail.com with ESMTPSA id 18sm542902qkh.40.2020.06.22.19.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 19:43:30 -0700 (PDT)
Message-ID: <03e82e1a1bcf516d01ca472546d8b31e468aba8b.camel@gmail.com>
Subject: Re: [PATCH 4/4] powerpc/pseries/iommu: Remove default DMA window
 before creating DDW
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 22 Jun 2020 23:43:24 -0300
In-Reply-To: <cfb197e1-c608-71f9-5c98-c120a3496266@ozlabs.ru>
References: <20200619050619.266888-1-leobras.c@gmail.com>
         <20200619050619.266888-5-leobras.c@gmail.com>
         <ade15776-61d1-b660-db74-7aeba4eddfdf@ozlabs.ru>
         <4bf1d32da3d13a44e3c2e4b04f369fe52c24a023.camel@gmail.com>
         <afd1c5ac-d291-5281-1592-a345ee3c0c8c@ozlabs.ru>
         <205edd45b7bbf39d2fc1d2d75fd7e35336f109ac.camel@gmail.com>
         <cfb197e1-c608-71f9-5c98-c120a3496266@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-23 at 12:35 +1000, Alexey Kardashevskiy wrote:
> > I am not sure if this is true in general, but in this device (SR-IOV
> > VF) I am testing it will return 0 windows if the default DMA window is
> > not deleted, and 1 after it's deleted.
> 
> Since pHyp can only create windows in "64bit space", now (I did not know
> until a few month back) I expect that thing to return "1" always no
> matter what happened to the default window. And removing the default
> window will only affect the maximum number of TCEs but not the number of
> possible windows.

Humm, something gone wrong then.

This patchset was developed mostly because on testing, DDW would never
be created because windows_available would always be 0.

I will take a deeper look in that.

Best regards,
Leonardo

