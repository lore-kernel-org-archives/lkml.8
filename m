Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3780DC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE649246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582901734;
	bh=uzF6Z9bvJm0pdIJlxAl+oKX05ewzkC/oD3pRBGnDBvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=w43HW4fjsA7Awe40IvwlJwepzDig6M42sP1Ll/36VB9JVIPtFaIWZyadBAwMj5Agv
	 je3CtN96+pur75SL8l+nrjBkUlAs4RIJHzOEspwNsdxSVWNxtEPMPpD73wDyPelgjB
	 ABebQQxRq9UotSdTlJtR8K8NTsozyW9jilPxWI60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgB1Ozd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:55:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:42556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgB1Ozc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:55:32 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52107246A0;
        Fri, 28 Feb 2020 14:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582901731;
        bh=uzF6Z9bvJm0pdIJlxAl+oKX05ewzkC/oD3pRBGnDBvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M+RDVR5DhyOio5Z4jZFVwnnai4AGoFwBAYNiL93GnNbvELW/wTC+W32G3kBNsWlrm
         tPqtiw6UrVbJqhd+CzDozkerEsOn5ivs2mfn5S8XzbjL6puAyHna6hk4Fx/XEAunuM
         xOi+v1aDVYFJK1FrxbSXRGOPHPkD3sAZGwNXWpzA=
Date:   Fri, 28 Feb 2020 23:55:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [v2 0/1] Documentation: bootconfig: Documentation updates
Message-Id: <20200228235528.acfc091ee58d4d685a119f4f@kernel.org>
In-Reply-To: <0d7d201c-e313-6129-7cfa-4e61eb31342d@web.de>
References: <158287861133.18632.12035327305997207220.stgit@devnote2>
        <957cef56-04b0-3889-6c95-a8ed7606b68d@web.de>
        <20200228222311.f5b9448027031b16a3be372a@kernel.org>
        <0d7d201c-e313-6129-7cfa-4e61eb31342d@web.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 15:05:42 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> > So, if you are interested in it, I don't stop you to write it up.
> 
> Will the collaboration continue anyhow?

It's your turn. "ask not what your community can do for you - ask what you can do for your community." :)
Collaboration is not just talking, but move things step forward.

> Will the clarification become more constructive for remaining challenges?

If you think so, you can send a patch for it.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
