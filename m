Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49153C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2059521835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgEAXmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:42:06 -0400
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:55704 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAXmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:42:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0BB385DFE;
        Fri,  1 May 2020 23:42:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cork13_4c471c5cc535c
X-Filterd-Recvd-Size: 3183
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 May 2020 23:42:04 +0000 (UTC)
Message-ID: <e1e12e3f6992c00c005ba2b3bcf671c033a1dccc.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add NL_SET_ERR_MSG to 80 column exceptions
From:   Joe Perches <joe@perches.com>
To:     Jacob Keller <jacob.e.keller@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Fri, 01 May 2020 16:42:02 -0700
In-Reply-To: <20200501231131.2389319-1-jacob.e.keller@intel.com>
References: <20200501231131.2389319-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-01 at 16:11 -0700, Jacob Keller wrote:
> NL_SET_ERR_MSG and NL_SET_ERR_MSG_MOD are used to report extended error
> responses about failure of a netlink command. These strings often end up
> going over the 80-column limit. Just like logging messages, it is
> preferred to leave the message all on a single line.
> 
> Add these to the exception list so that checkpatch.pl will no longer
> complain about the long lines due to use of these macros.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index eac40f0abd56..5da3b06fbeaa 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -471,7 +471,8 @@ our $logFunctions = qr{(?x:
>  	WARN(?:_RATELIMIT|_ONCE|)|
>  	panic|
>  	MODULE_[A-Z_]+|
> -	seq_vprintf|seq_printf|seq_puts
> +	seq_vprintf|seq_printf|seq_puts|
> +	NL_SET_ERR_MSG(?:_MOD)?
>  )};
>  
>  our $allocFunctions = qr{(?x:

<shrug>  OK I guess.

What about GENL_SET_ERR_MSG ?

btw:

There are some uses with what appear to be unnecessary newlines.
Maybe these newlines should be removed.

drivers/net/ethernet/mscc/ocelot_tc.c:50:			NL_SET_ERR_MSG_MOD(extack,
					   "Only one policer per port is supported\n");
drivers/net/ethernet/mscc/ocelot_tc.c:61:			NL_SET_ERR_MSG_MOD(extack, "Could not add policer\n");
drivers/net/ethernet/mscc/ocelot_tc.c:74:			NL_SET_ERR_MSG_MOD(extack,
					   "Could not delete policer\n");
drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:1099:			NL_SET_ERR_MSG_MOD(extack,
					   "Failed to create tc offload table\n");
net/dsa/slave.c:915:		NL_SET_ERR_MSG_MOD(extack,
				   "Policing offload not implemented\n");
net/dsa/slave.c:920:		NL_SET_ERR_MSG_MOD(extack,
				   "Only supported on ingress qdisc\n");
net/dsa/slave.c:930:			NL_SET_ERR_MSG_MOD(extack,
					   "Only one port policer allowed\n");
net/bridge/br_stp_if.c:205:		NL_SET_ERR_MSG_MOD(extack,
				   "STP can't be enabled if MRP is already enabled\n");
net/bridge/br_mrp_netlink.c:31:		NL_SET_ERR_MSG_MOD(extack, "MRP can't be enabled if STP is already enabled\n");


