Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E121C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD16207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595338290;
	bh=c8giteNFeamqKLoW15EsJhTiRUo6tlxFnNCnqM1rW5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JaRMx7Iv1Fgx2z0oQKyUh1ELqTifs6+kaNhGqUfwUUZM0c4YNDRQXRNifd+XBheiM
	 fo/0JCaLZq7IW3HYVQoU9wzmo3ZiF56qcb1hxyPGngnA6Fxa20MOcAeVz6JckEpikC
	 2uw3roQvY1ddeQNj8ps/m4Kw1eX8TmdZ/8t6qp0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgGUNb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgGUNb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:31:29 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0A57206E9;
        Tue, 21 Jul 2020 13:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595338288;
        bh=c8giteNFeamqKLoW15EsJhTiRUo6tlxFnNCnqM1rW5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ys0FmYY/GAwxv/oVTRBGAt9KaBPfhYsnTtshYbvwQfad5BJNyu4B20jfg3QG/cYhd
         KVDPMka9rtDRaE8NtML5mig0AL/s2DeRafgjYAUUzhOAe9NJaoWaECepf0isSOSASH
         0F4r4oiRJ6HBrWn4F8M/Dgd4KNXMgyljCMjXGvxw=
Date:   Tue, 21 Jul 2020 22:31:25 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] docs: kprobes: Update URLs and move under trace/
Message-Id: <20200721223125.7473edbb7da7693cc1fa6984@kernel.org>
In-Reply-To: <cover.1595331824.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1595331824.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naveen,

On Tue, 21 Jul 2020 17:18:19 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> This series updates some of the URLs in the kprobes document and moves 
> the same under trace/ directory.

Thank you very much for fixing and updating it!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

for this series.

Thanks!

> 
> - Naveen
> 
> 
> Naveen N. Rao (3):
>   docs: staging/kprobes.rst: Update some of the references
>   docs: staging/kprobes.rst: Move references to a separate appendix
>   docs: Move kprobes.rst from staging/ to trace/
> 
>  Documentation/staging/index.rst              |  1 -
>  Documentation/trace/index.rst                |  1 +
>  Documentation/{staging => trace}/kprobes.rst | 16 +++++++++-------
>  3 files changed, 10 insertions(+), 8 deletions(-)
>  rename Documentation/{staging => trace}/kprobes.rst (99%)
> 
> 
> base-commit: f33d4075e512274c0c6edcd7602da2cf1d5a0341
> -- 
> 2.25.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
