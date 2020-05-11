Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490FEC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C7020757
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589217715;
	bh=tLxkrmhQXyX7b1bTcRDkdDpgPTyxNen6bs9bJnit8HQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l71iByLkuGlZEovRoxcXUSTbu+GAAiVdQHdMjpZMv8SSqgvw+g9be8pWx3WyxfF/g
	 woTnJHvQHNQrkF9ZV/5cN5/292C3JC3s8JOsshXLytFx27gRvHPC5U6p+Px/Wseiv/
	 vULx/vNStHroLMLo16i3PAmjJMDz6ysDl45+3gZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgEKRVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbgEKRVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:21:49 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B4DE206D7;
        Mon, 11 May 2020 17:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589217708;
        bh=tLxkrmhQXyX7b1bTcRDkdDpgPTyxNen6bs9bJnit8HQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0aOsDPuEgkaqp+CwaPIoKUpAQ1Yhgy/YPVryPk98JvkcESzcmL+qtHj2rH9aBLfSd
         7k4UNacnQ3F+z4Fv9cotIr3i/rQhNYIDOWoow0Eqdo18nH6oGa2OmrH6zJjjqjnnf5
         pMvp722fZ/aQqdCtti5Y2anKKSYsBHnDBV+eQSyI=
Date:   Mon, 11 May 2020 12:26:20 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Replace zero-length array with
 flexible-array
Message-ID: <20200511172620.GA14618@embeddedor>
References: <20200507190615.GA15677@embeddedor>
 <20200511154812.GD5377@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511154812.GD5377@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 12:48:12PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 07, 2020 at 02:06:15PM -0500, Gustavo A. R. Silva escreveu:
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][2],
> > introduced in C99:
> > 
> > struct foo {
> >         int stuff;
> >         struct boo array[];
> > };
> 
> Can you split this into a kernel part and tools/ one? Also this is not
> really just for "perf script", so please adjust the subject line too :-)
> 

Sure thing. :)

Is that OK if I use "perf: " for the tools part and "perf/x86: " for the
kernel part?

Thanks
--
Gustavo
