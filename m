Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF3C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A0B20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbgCLFzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 01:55:48 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55968 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387677AbgCLFzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 01:55:47 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2C17C14C7E036;
        Wed, 11 Mar 2020 22:55:46 -0700 (PDT)
Date:   Wed, 11 Mar 2020 22:55:45 -0700 (PDT)
Message-Id: <20200311.225545.780993448550563267.davem@davemloft.net>
To:     frextrite@gmail.com
Cc:     kuba@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
        rfontana@redhat.com, allison@lohutok.net, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        joel@joelfernandes.org, madhuparnabhowmik10@gmail.com,
        paulmck@kernel.org, lkp@intel.com
Subject: Re: [PATCH] net: caif: Add lockdep expression to RCU traversal
 primitive
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200312053419.12258-1-frextrite@gmail.com>
References: <20200312053419.12258-1-frextrite@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 11 Mar 2020 22:55:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amol Grover <frextrite@gmail.com>
Date: Thu, 12 Mar 2020 11:04:20 +0530

> caifdevs->list is traversed using list_for_each_entry_rcu()
> outside an RCU read-side critical section but under the
> protection of rtnl_mutex. Hence, add the corresponding lockdep
> expression to silence the following false-positive warning:
> 
> [   10.868467] =============================
> [   10.869082] WARNING: suspicious RCU usage
> [   10.869817] 5.6.0-rc1-00177-g06ec0a154aae4 #1 Not tainted
> [   10.870804] -----------------------------
> [   10.871557] net/caif/caif_dev.c:115 RCU-list traversed in non-reader section!!
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Amol Grover <frextrite@gmail.com>

Applied, thank you.
