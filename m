Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5934AC7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A6D20726
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581921508;
	bh=JVqwlL4yhQ5lezwX7g+G9KjZQyORJmAsbJv5b348mGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pSoKZCPG/qm8UOtBtfJOgFps9d7Qkyl7CNos2QdngrDeCFBCq8MUZCb5RWEBPc+Pk
	 vPYpDvJOehuYT4qXo8jktwRNqJN5qVUXWBbPyacHmDs50sOwowaTn6xy/wZr5qNazF
	 9+NdD1KEss/1JJJP1jAi2KVT1F/jcfhGbSQpJ6h4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgBQGi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:38:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgBQGi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:38:26 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFA7320718;
        Mon, 17 Feb 2020 06:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581921506;
        bh=JVqwlL4yhQ5lezwX7g+G9KjZQyORJmAsbJv5b348mGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HuLZF1eD/1LHnn31hy/z1l4LC74PFpw0aINQyWvKsdkSq1Th5fp6fEoD9cQNj2EN3
         lOTopoNe5A/QzCfg5JuRzhOIGEwnMk1DUme3SBSh1DBDmj1tU/OeCSDlREstHFpic/
         Xf0GpsYOzmjH0S6dsL3caXfa/CKQIDKhEi39W0UU=
Date:   Mon, 17 Feb 2020 14:38:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, allison@lohutok.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de, abel.vesa@nxp.com,
        leonard.crestez@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/5] clk: imx6sl: Add missing of_node_put()
Message-ID: <20200217063810.GD6952@dragon>
References: <1581508657-12107-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581508657-12107-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 07:57:33PM +0800, Anson Huang wrote:
> After finishing using device node got from of_find_compatible_node(),
> of_node_put() needs to be called.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
