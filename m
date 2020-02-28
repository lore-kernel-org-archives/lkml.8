Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C17C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D962246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582859741;
	bh=bP/pt7lgm/aRI4m8r78wN75tpYTiIei79Uime6uh70Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LnndUqvli5yxBqC4/kVRV3A66jQraane5AzEGsSpbFzS0cgpAme9BNwsKfBvmjzTb
	 P4sp5ayzhBtVcER7LxNjdtWr/dvhFG/E/ChBIm6X826zGT+eX9OwPBTdchrnlE3fi5
	 cuzbxo+Vn0ZnOOCdajXBTrm4NwE1S9iIEy6mwHuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbgB1DPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:15:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730569AbgB1DPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:15:39 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C7E52469D;
        Fri, 28 Feb 2020 03:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582859739;
        bh=bP/pt7lgm/aRI4m8r78wN75tpYTiIei79Uime6uh70Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R8h1iJXoXJzzYQPKRQPg2tgrYijzLEN/Q7nRgjAc/RI8B9FdpQlisXVFiRaUgZ+nM
         8qyfN6/OKg63TVM0mleW97377oPKSaK5isyb0YAk38WBctUV0V5scNwqAP7nImNUzg
         FE41onIuxYk/obHWO6seNPuqvyK2/IGg+Rrncxt8=
Date:   Fri, 28 Feb 2020 12:15:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: bootconfig: Add EBNF syntax file
Message-Id: <20200228121535.0c0e0e67fb11f1e07ea18e4c@kernel.org>
In-Reply-To: <2390b729-1b0b-26b5-66bc-92e40e3467b1@web.de>
References: <158278834245.14966.6179457011671073018.stgit@devnote2>
        <158278836196.14966.3881489301852781521.stgit@devnote2>
        <2390b729-1b0b-26b5-66bc-92e40e3467b1@web.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 20:53:03 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> Thanks for such a contribution.
> 
> 
> > Add an extended Backus–Naur form (EBNF) syntax file for
> 
> Can it matter to mention the specific file format specification version
> which should be applied finally?
> 
> Would you like to refer to any standard variant?

I choose ISO/IEC 14977 : 1996(E), but it seems no good.

Don’t Use ISO/IEC 14977 Extended Backus-Naur Form (EBNF)
https://dwheeler.com/essays/dont-use-iso-14977-ebnf.html

I agree with this article. the ISO 14977 is halfway...
Not easy for human, but not good for machine too.
(at least it should support #xN as same as W3C BNF.

I'll drop it until rewriten by other standerd.

> > bootconfig so that user can logically understand how they
> 
> Wording alternative “… that users can …”?
> 
> 
> > can write correct boot configuration file.
> 
> Related development tools provide some benefits then, don't they?
> 
> 
> 
> …
> > +++ b/Documentation/admin-guide/bootconfig.ebnf
> …
> > +digit = "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ;
> 
> Can the specification of such alternatives (or value ranges) become
> more compact (depending on a selected standard)?

W3C EBNF support it, ISO14977 doesn't.

> …
> > +++ b/Documentation/admin-guide/bootconfig.rst
> …
> > +Here is the boot configuration file syntax written in EBNF.
> 
> I suggest to replace the abbreviation “EBNF” by the term “extended Backus–Naur form”
> in such a sentence.

I think EBNF is enough.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
