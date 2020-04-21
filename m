Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC7BC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF4BE2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587490044;
	bh=6F88OaqaZARKiiq4BVaD5EAs6uHYTsDfOJHwUXlV74g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aX1+RRFYfYgDKJLeDxYWT/WIzewp23hSUONURzsaJSFMZNTMdH7cVCoGGp+MAPRTH
	 6wKX1iKHnNaIcYoLSV25v93ZWe5FxPdTzDEIYVydUp1KtmxD21zbsP7d2UDfAD0+1A
	 iphTdXPKe2WZjJOTFxzxYyDcCK7uF3Vbdi1jwgNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgDUR1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbgDUR1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:27:23 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEE792071C;
        Tue, 21 Apr 2020 17:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587490043;
        bh=6F88OaqaZARKiiq4BVaD5EAs6uHYTsDfOJHwUXlV74g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jo7/kyYYKof0tL8x1R93fvLWZXOI5wW4CbtaUUZYnkMzeysMjnRKqyxyEM0Kx2I7D
         R9HX3N0T8g6HcaPVtcbWa18T13akgONCUW6Z4C3yzZTD1PO5ZX/7NxdnTxHj5k3eiQ
         Ep5zqFJh+uMKCnpZWCawOJ5qOFP5YAy1Mebh3554=
Date:   Tue, 21 Apr 2020 10:27:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <zenczykowski@gmail.com>
Cc:     Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] [RFC] net: bpf: make __bpf_skb_max_len(skb) an
 skb-independent constant
Message-ID: <20200421102719.06bdfe02@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200420231427.63894-1-zenczykowski@gmail.com>
References: <20200420231427.63894-1-zenczykowski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 16:14:27 -0700 Maciej =C5=BBenczykowski wrote:
> From: Maciej =C5=BBenczykowski <maze@google.com>
>=20
> This function is used from:
>   bpf_skb_adjust_room
>   __bpf_skb_change_tail
>   __bpf_skb_change_head
>=20
> but in the case of forwarding we're likely calling these functions
> during receive processing on ingress and bpf_redirect()'ing at
> a later point in time to egress on another interface, thus these
> mtu checks are for the wrong device.

Interesting. Without redirecting there should also be no reason
to do this check at ingress, right? So at ingress it's either=20
incorrect or unnecessary?
