Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1918C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 16:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D2D2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 16:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593968021;
	bh=tjL78wxIVG1upw7m/DW1G6vT4WoY+4jEPS2ZMixS96M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2dQADoXEJh6AfyLJofFtHZAauc6FcCRpJkn1M3OrSoc6jrqX3yw4qHsjFUpoIhqAR
	 H89bVg82z1YpdTvNLL/caCuhRlCn8axthxUggGwckiLsuf/cgHMbVuie06ycjov2up
	 xSy4Bu0N3VXn5bI1mYqUtMit+Tja2ybmz1hfw25Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgGEQxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 12:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgGEQxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 12:53:39 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC2FD20760;
        Sun,  5 Jul 2020 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593968019;
        bh=tjL78wxIVG1upw7m/DW1G6vT4WoY+4jEPS2ZMixS96M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nZl7wxHORfsXqpkNhWfkE83hwq6OoGl9xka/xZCbarK7flihQXxRa5n2aWfZQvf4F
         LYale6U5MdRezdUBTaW23FnG7hv8YH3BQQcxLrRM/EtHdKAh6OP6aA1fKAzAVoPe51
         wiEqBnL06R0aC7WaZxMUtCz9CKeVdt27I2nv/0ZI=
Date:   Sun, 5 Jul 2020 09:53:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests/seccomp: Refactor to use fixture variants
Message-ID: <20200705095337.367278bd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200705061232.4151319-3-keescook@chromium.org>
References: <20200705061232.4151319-1-keescook@chromium.org>
        <20200705061232.4151319-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Jul 2020 23:12:31 -0700 Kees Cook wrote:
> Now that the selftest harness has variants, use them to eliminate a
> bunch of copy/paste duplication.
> 
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Jakub Kicinski <kuba@kernel.org>
