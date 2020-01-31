Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92477C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A86206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgAaS3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:29:22 -0500
Received: from correo.us.es ([193.147.175.20]:51462 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgAaS3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:29:22 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C8A70FB36B
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 19:29:21 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B9A82DA717
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 19:29:21 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id AE77EDA707; Fri, 31 Jan 2020 19:29:21 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C0C6DDA705;
        Fri, 31 Jan 2020 19:29:19 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 31 Jan 2020 19:29:19 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A4DAF42EFB80;
        Fri, 31 Jan 2020 19:29:19 +0100 (CET)
Date:   Fri, 31 Jan 2020 19:29:18 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netfilter: nf_flowtable: fix documentation
Message-ID: <20200131182918.zfndm623af6bhxog@salvia>
References: <20200130191019.19440-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130191019.19440-1-mcroce@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 08:10:19PM +0100, Matteo Croce wrote:
> In the flowtable documentation there is a missing semicolon, the command
> as is would give this error:
> 
>     nftables.conf:5:27-33: Error: syntax error, unexpected devices, expecting newline or semicolon
>                     hook ingress priority 0 devices = { br0, pppoe-data };
>                                             ^^^^^^^
>     nftables.conf:4:12-13: Error: invalid hook (null)
>             flowtable ft {
>                       ^^

Applied, thanks.
