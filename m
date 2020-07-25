Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856F8C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 17:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB5D206E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 17:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595697690;
	bh=Rteg0/PtsTehHLQ/ZXCZ6zO53UN+mrJQNeQDprdEaOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cuhrt/qmdRnYPhLGrByjRX9QKNU9T41UCqiyi0+HdojvrZhqiFD7qumwXeGpnqTwJ
	 C+5mdME84lCEqUkEA2/ftUyLc3ggbLdH1ERagBl5RPdHW8QrnDFQQCC7D3VwfxXfat
	 PHx0F2+TuRpLpgiclaGilYuoC68Y60mnHC3g5GNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgGYRV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 13:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbgGYRV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 13:21:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B012A206D8;
        Sat, 25 Jul 2020 17:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595697687;
        bh=Rteg0/PtsTehHLQ/ZXCZ6zO53UN+mrJQNeQDprdEaOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x90CcWVOFR0mAI7+jp3d5kwU6PyHqj0Ewfq4evGmICrUkHABME96x452iXB5gy26Y
         y5OXtbylWE+Gy04JXx/plhItOwYnqOoxyqE/BufC1pKTdFZjUEQFCppOc2HPR4g6rt
         XdNMdIldldD5AeXFrdcPoG/4lCP0R4bZkmBzU9gg=
Date:   Sat, 25 Jul 2020 19:21:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gustavo@embeddedor.com
Subject: Re: [PATCH V3] staging: rtl8723bs: core: Using comparison to true is
 error prone
Message-ID: <20200725172124.GB405510@kroah.com>
References: <20200725143712.16667-1-john.oldman@polehill.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725143712.16667-1-john.oldman@polehill.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 03:37:12PM +0100, John Oldman wrote:
> clear below issues reported by checkpatch.pl:
> 
> CHECK: Using comparison to true is error prone

Again, you did more than just this in the patch :(
