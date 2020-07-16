Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C172EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FC120663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594870502;
	bh=H10niYhCOD51oV4cjPAgIcvgQLll9XZwC4zecYnyZYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aclfkYzfptuws0zMJB/lTT4CF4ofRjNNzmyClPj1WzPXlijJL+sQ6gAkGN3hq0jLA
	 CYk0CLFde+uVqQb2ikNbku4VT7zshniJvYMeNCd3REvPvD/7tn7oLAKqG0LCddoQuj
	 09cEOs93Z6OXHg/+coye9HQJV77eamnpx3USeVOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgGPDe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbgGPDe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:34:56 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FC0D20663;
        Thu, 16 Jul 2020 03:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594870495;
        bh=H10niYhCOD51oV4cjPAgIcvgQLll9XZwC4zecYnyZYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oMFf0eMfz9l7O/DkExLwh/lXZhv+nH0QBDu5JU/JbY4Lf/iVdJWDGmvpDs2nK/d6b
         nyVX5cpsi06GmB4LmNmg/942tSviIUMpICvMmdHy9nPy9qPBvkPoptjaAH7m6DfyvX
         MD5Qx8cnosEryphMG4xhUqQ6ChGuzwsJoymMPs1M=
Date:   Wed, 15 Jul 2020 20:34:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 3/9 v2 net-next] net: wimax: fix duplicate words in
 comments
Message-ID: <20200715203453.4781ddee@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200715164246.9054-3-rdunlap@infradead.org>
References: <20200715164246.9054-1-rdunlap@infradead.org>
        <20200715164246.9054-3-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 09:42:40 -0700 Randy Dunlap wrote:
>  /*
> - * CPP sintatic sugar to generate A_B like symbol names when one of
> - * the arguments is a a preprocessor #define.
> + * CPP syntatic sugar to generate A_B like symbol names when one of

synta*c*tic

Let me fix that up before applying.

> + * the arguments is a preprocessor #define.
>   */

