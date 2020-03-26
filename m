Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273F9C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC51020772
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="KBtSOHcd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V4U16Jhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgCZHzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:55:54 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42925 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbgCZHzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:55:53 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 719715C01B6;
        Thu, 26 Mar 2020 03:55:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 26 Mar 2020 03:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=qGS7fxMN3bdJeTQ2Uh5K4EGioNW
        sZ98ON7t12DCIM/M=; b=KBtSOHcdx53Urx38/eV2mpj5vDJNGrySrmnZosNOHGR
        uD5Q6SqC1TtFaGW9nle6G0U4JkYmEswXNSi6kZzv29asdUDEnbSuP2EGp+SUYyOs
        XwLp+dbE6ZNXFNG8gDFMY41wVrvpV1WmP7GVkIHryx9oPKRAXKVAlvR1FKRUV47n
        NupgwE8ghAuAIY5IllogMcTrEcTxHFCOPvaK3mmUo4VZKCZQX8sOZxSEIjCdOZyr
        ++LmnrVN0te6iLvD+2Fq7Nxpb6ppzEm+oaUq98mz6TimWG2hNeeSLgRiCuI071Bu
        Z7GT9NzrEBBeWU0AoOnERoLvc5XoFDZd9HlT0/XZ1Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qGS7fx
        MN3bdJeTQ2Uh5K4EGioNWsZ98ON7t12DCIM/M=; b=V4U16Jhbi6rBK1+qeq1n5f
        e5jdE3bmVBueeYx8kHhGHW73ihFEr/ghSu8PWJswktoKmf0lzUpQmSfV2jRwL1dC
        liwGiMPImvYNHeZPN0gUtUVMraVUb3WZ/JbcAGG2eKDlXE75nDHXQFZE33nd1xmX
        Cp/t6o4g5umtcsdFvxetdCVI20O57Bop7s+cS4/a2PyO55+iLNw9btUBPgbVhkvZ
        XOYeRRoCedoZ46f9sTDoJDMKJLH4Jxjusk6XzkyL73zcUzaq3CvXlnBQySAY26Ck
        fUKcTIO/8OlESyZ4Cz//Nt+boqaTPs5t5i8WIA+qQBpfhDEU5CLbLdCXevGwafMg
        ==
X-ME-Sender: <xms:CGB8XoJtz_omuU-gmG9thOO3S3bReSB7V0743bOWBOsuXRpZbMCkVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehhedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    rhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:CGB8XoTtHeG0bqIbIDmHpz27fx6DH1GQiNhnfLkC6WzzBcXuxb2oNQ>
    <xmx:CGB8XgrDpZhcdz9t_bm5w0RNRCd0y_1BIb4GS94Nn8eo--gfUYbuCA>
    <xmx:CGB8XtrHNcgjpqUNIao9lzXBWzbP8NIANdi3BRU72YAUsCJHse7IEQ>
    <xmx:CGB8XpodEnnlrijhWoOFJjm4t_2UMFzakzq4Ct9TIG2en5Ufj8vadw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F8B03069194;
        Thu, 26 Mar 2020 03:55:51 -0400 (EDT)
Date:   Thu, 26 Mar 2020 08:55:50 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: linux-next: manual merge of the rcu tree with the spdx tree
Message-ID: <20200326075550.GB957772@kroah.com>
References: <20200326141235.718118af@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326141235.718118af@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 02:12:35PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rcu tree got a conflict in:
> 
>   tools/memory-model/litmus-tests/.gitignore
> 
> between commit:
> 
>   d198b34f3855 (".gitignore: add SPDX License Identifier")
> 
> from the spdx tree and commits:
> 
>   5381fb2b70e9 ("tools/memory-model: Move from .AArch64.litmus.out to .litmus.AArch.out")
>   dafa02882066 ("tools/memory-model: Keep assembly-language litmus tests")
> 
> from the rcu tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks good, thanks.

greg k-h
