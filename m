Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C59BC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2548F221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoQ3W5yI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgIKKM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgIKKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:12:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF53C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 03:12:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id p9so13052978ejf.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 03:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IXsZZvpxC3Iw+tC6jnLuPh79RFUv3V9xAF5t6zWzAOg=;
        b=OoQ3W5yI+cDCOsdiS14DqDREtdwPDcCIfsTCV48IZAq+GQHCb1X7M6BFss9tC1mbzo
         24lpHSsA8AqLn/YlG+ZYMAKhrY3aRO+v5sI6Win2/yx6phLSNPnQMdli/Czw3pP4Q4Op
         dK/zpEaQIzZkNe4yGU5Mxb+RC5Laj6CbZyfoYuYgb9ShN7pAV+AOMA1UGbrY66FWj1pv
         ZP7w6FM6dRn+wxMReKrnPSJ8ZYndzZUNL3CEH8rd1Io8kTmIp/G2iN1j0G3wS42osEhz
         yQw8rOuBZZovcc2SI33iLRL6iL6I0BhcHzthdUqHB2HbmUiH5SE7vv/NpNIx28UkPEkh
         u92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IXsZZvpxC3Iw+tC6jnLuPh79RFUv3V9xAF5t6zWzAOg=;
        b=kuCgl1rSTauAtq9QpAkuEkPq7KxSTYDW3mGSxTfzf/QjaIaCDwqdI7HL1qMYDlXQRu
         2X/lc3pX9zKpJOE7GHQfHF4oGuWEwkgo2rH4LQnyGvclTnx0UjYyLnL0bF0Zj7CWNgll
         v9Cx6jue07tOV06/IcdVxB/FAHt14kSnExAmXzX+dXKAhqI2roMEE3f8Tsu8OoLOAsV2
         fj9zx8pM7WNTxGU6noar1qD9F0BnM09hnCavJIrOleV3Lbg0JzVvgsnWJ2/0KRivH950
         WyHslzWoRWEJwW0gnDgK/ojmStDWo9Hk/9/podS/Sj4RLgc4778KreW9BfSrkL5l2UUe
         SMWg==
X-Gm-Message-State: AOAM530xLPqO6mmx8YkTbTKj0zqv0UoN5wsD6mDAMkaRN+hR5FpdFovE
        9/UbgqUurJvbKLVyl77FGxk=
X-Google-Smtp-Source: ABdhPJwCcQslkt8qwuJRF2M7tnbJpACj1itr3BA1247tseaj1i83uITOeaEcPZMrg1hyjPv00uG7XA==
X-Received: by 2002:a17:906:4819:: with SMTP id w25mr1313314ejq.300.1599819167936;
        Fri, 11 Sep 2020 03:12:47 -0700 (PDT)
Received: from felia ([2001:16b8:2dfa:1900:b0c3:335:87f7:d616])
        by smtp.gmail.com with ESMTPSA id q13sm1281850edr.27.2020.09.11.03.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 03:12:47 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 11 Sep 2020 12:12:41 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Christoph Hellwig <hch@infradead.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: MAINTAINERS: Marking internal distribution lists
In-Reply-To: <20200911094627.GA14158@infradead.org>
Message-ID: <alpine.DEB.2.21.2009111154500.16254@felia>
References: <alpine.DEB.2.21.2009110811520.9220@felia> <20200911094627.GA14158@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Sep 2020, Christoph Hellwig wrote:

> On Fri, Sep 11, 2020 at 08:37:54AM +0200, Lukas Bulwahn wrote:
> >   - ocfs2-devel.oss.oracle.com
> 
> This is a normal mailing list, and I subscribed to it normally.  It
> might howerever be brken in various ways as oss.oracle.com seems
> pretty much unmaintained.
> 
> >   - rds-devel.oss.oracle.com
> 
> The same probably applies here.
>

Thanks, Christoph; it seems that I miscategorized those two email 
addresses in my first attempt going through the data.

I found the URLs how to subscribe to those mailing lists, so no help from 
Martin is required here.

Lukas
