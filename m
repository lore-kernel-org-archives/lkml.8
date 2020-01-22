Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC33C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0915A24676
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579700456;
	bh=Nk9rSrfpF+VW2lOBu5fhnBOzyu1Gej8y4Rwfx32PrvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2iev9v01zVa4y+cPI9Ca6cPQLahFb6iJmlS2zeCLu0NnmLBzkDpg9Hs+DIwpESiTT
	 wk4ya8vW/uTShFALt0p2Dlk7Awg83XBV7umEBBJJoBjuQU9u3OE01nlhm/IzrWlyEO
	 R3pDK6Z/xUc2HdX0iUpmHhZHfvka9O0+/FliWdqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAVNkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:40:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:33804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgAVNkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:40:55 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 979CF2073A;
        Wed, 22 Jan 2020 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579700454;
        bh=Nk9rSrfpF+VW2lOBu5fhnBOzyu1Gej8y4Rwfx32PrvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5I6IuxX6/WQrzjyQ3LaLhAJ28ryheDoCVlOnsolAJXrU5/5FswR85nMbva2+mm7G
         e5x52qz9k8KDQ9gL2a5ZAlt8rjyb6VUwKfZs9RsR60uY9r2SjDDBn3iTBb4bwAgkSN
         rNqo4tXNNYMWf/azpwKU5h6/S9GZHMshqC7jx6bU=
Date:   Wed, 22 Jan 2020 14:40:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Brown <broonie@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/38] platform/x86: intel_scu_ipc: Reformat
 kernel-doc comments of exported functions
Message-ID: <20200122134050.GD4963@kroah.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-14-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121160114.60007-14-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 07:00:49PM +0300, Mika Westerberg wrote:
> Format kernel-doc comments of the exported functions to follow the
> typical format that does not have tab indentation. Also capitalize
> parameter descriptions and add a missing period.

This should go in the first set of "cleanup" patches, right?

thanks,

greg k-h
