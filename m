Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9970AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7364A20782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHYQBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:01:21 -0400
Received: from smtprelay0079.hostedemail.com ([216.40.44.79]:55326 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726222AbgHYQBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:01:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 00B8A837F24F;
        Tue, 25 Aug 2020 16:01:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jar75_46028082705d
X-Filterd-Recvd-Size: 3756
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 16:01:02 +0000 (UTC)
Message-ID: <ec1410782019a2e43399445206e673273fd12c31.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: add namespace entry
From:   Joe Perches <joe@perches.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 25 Aug 2020 09:01:01 -0700
In-Reply-To: <20200825154148.1219500-1-christian.brauner@ubuntu.com>
References: <20200825154148.1219500-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-25 at 17:41 +0200, Christian Brauner wrote:
> Namespace maintainership has never been formalized which has led to confusion
> when people need to determine where to send patches and who should take a look
> at them. Especially, since we have a dedicated list
> containers.lists.linuxfoundation.org already for a long time. In preparation of
> this patch I added the containers.lists.linuxfoundation.org mailing list to be
> archived on lore.
> 
> This will not just make it easier to catch and review patches specific to
> namespaces and containers but also for changes not specifically touching
> namespaces but which nevertheless will have impact on namespaces and
> containers.
> 
> Add an entry for Eric (who agreed to this) and me and add a first batch of
> files that are relevant. Currently, only a small set of files are added and
> only such namespaces that haven't gotten a separate maintainers entry (e.g.
> time namespaces). I expect this to grow more entries and/or regular expressions
> over time. For now these entries here are sufficient. I intend to route this
> patch upstream soon.
> 
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  MAINTAINERS | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0068bceeb61..272211cdc327 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11892,6 +11892,26 @@ S:	Supported
>  W:	https://www.cspi.com/ethernet-products/support/downloads/
>  F:	drivers/net/ethernet/myricom/myri10ge/
>  
> +NAMESPACES AND CONTAINERS
> +M:     Christian Brauner <christian.brauner@ubuntu.com>
> +M:     Eric W. Biederman <ebiederm@xmission.com>
> +L:     containers.lists.linuxfoundation.org
> +S:     Supported
> +T:     https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/
> +T:     https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/
> +F:     ipc/namespace.c
> +F:     kernel/nsproxy.c
> +F:     kernel/pid_namespace.c
> +F:     kernel/user_namespace.c
> +F:     kernel/utsname.c
> +F:     include/linux/nsproxy.h
> +F:     include/linux/ipc_namespace.h
> +F:     include/linux/ns_common.h
> +F:     include/linux/nsproxy.h
> +F:     include/linux/pid_namespace.h
> +F:     include/linux/user_namespace.h
> +F:     include/linux/utsname.h

Please sort the filename order alphabetically.

F:	include/linux/ipc_namespace.h
F:	include/linux/ns_common.h
F:	include/linux/nsproxy.h
F:	include/linux/nsproxy.h
F:	include/linux/pid_namespace.h
F:	include/linux/user_namespace.h
F:	include/linux/utsname.h
F:	ipc/namespace.c
F:	kernel/nsproxy.c
F:	kernel/pid_namespace.c
F:	kernel/user_namespace.c
F:	kernel/utsname.c


