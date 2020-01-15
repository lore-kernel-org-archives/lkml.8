Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114CEC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFB12187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579104212;
	bh=M+ejBefptVuwNM2TiUBU0HaQoqC1lnCmwJ6aKNHQPVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2u0ujq/YqECwsC+n7QD2FmQf8kMbkFvpC8L3VsjPv5LcFHGsHUSqoihXfesB9jJej
	 FaqYKvBiDt1hzbdJ7EVIwoSpQz5c/hY2aFzPDNMqOAPUa8vI/biSc8+uV6IgBhrZ06
	 dQA4kkbnm4Ju88KeolGIDCbgT5VN5TRmXmo7QtnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAOQDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:03:31 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42602 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgAOQDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:03:31 -0500
Received: by mail-qv1-f66.google.com with SMTP id dc14so7562540qvb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 08:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mk2uwyhn9dEm5lXEb80qDNKTst9+d+Ocygo5/sdL9d0=;
        b=liwnpFCatPwUBDeFz6uuv16OAaJgd0+kEvTBF8Otyit+JHuuuN3Q8yZg6VE/rdNgqf
         bLdLvsd1QGBC58paAnNkXawncClATgYpI4pWyiWDRQbdP3OE0LgfupOFztw0KGvmsy9H
         mvnZZFa9lEB0hAIAg4ItPxemytlTuDHwHVDMocByE0dihVSkf+r0IhUxGZU7XDoHFMbq
         nILhipaAMiZexebt1ubIqvQfAmGEb15d3qCRZxPuju7r0zi/4TW16xAfM3tVHGhJHxYD
         iq8uBnv8WZzeG4fOr833WcmUIn64eq2V0+NIzjPY2P51nRh1toG83ms/Zsbtg+eFMoXO
         4KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mk2uwyhn9dEm5lXEb80qDNKTst9+d+Ocygo5/sdL9d0=;
        b=aA58L0I3T3YDNAqDW8aVa0KTQrxQTAVF9LZeZBunJfefjP+QV2Eef3dlB0E4e2xDLi
         OjILdp5B0KKwFqCn96XZOyPsjizEcQNWYfRqGvsCpiNeYGTOsf9/itA8tCPGcXXNHnh2
         pSsAd3HrUgyVARdKHtEgd9+XOmx4OFtZu0UCiOcx2gVt7K/uJR0/OOU6OmdXtwMoxQ13
         UWk2l9SMp99dLGQnGx8mfMSguiMi7hf52ZULhv8Z3lrU1ULkI5GsSZlpQiBmfVK/rf+u
         d3sBts9IXIjh3VjPMCGAKCBQfsIvDVbt17B0/BLmDOvNYdnKmllapHlo8orykY81X53S
         rafQ==
X-Gm-Message-State: APjAAAVczyHs1O8B2qmQYAFObZgmSGxryAJnp5OVlKtzvdgKTi76DTzp
        P2BYQ6U5bAJYCAevvfSny6JCQ+Tzlmc=
X-Google-Smtp-Source: APXvYqzP0ltSrjeK0J2sKy9chYDG4ByeV0ZSZ0w/dCrMiuy1aX/8P4OYTzvtXxeTMlmQb/BzPN54Qg==
X-Received: by 2002:a05:6214:3e7:: with SMTP id cf7mr22596791qvb.129.1579104210320;
        Wed, 15 Jan 2020 08:03:30 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:1e68])
        by smtp.gmail.com with ESMTPSA id i7sm8611393qkf.38.2020.01.15.08.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 08:03:29 -0800 (PST)
Date:   Wed, 15 Jan 2020 08:03:28 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] workqueue: remove workqueue_work event class
Message-ID: <20200115160328.GF2677547@devbig004.ftw2.facebook.com>
References: <20200113225240.116671-1-daniel.m.jordan@oracle.com>
 <20200113225240.116671-2-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113225240.116671-2-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 05:52:40PM -0500, Daniel Jordan wrote:
> The trace event class workqueue_work now has only one consumer, so get
> rid of it.  No functional change.
> 
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: linux-kernel@vger.kernel.org

Applied 1-2 to wq/for-5.6.

Thanks.

-- 
tejun
