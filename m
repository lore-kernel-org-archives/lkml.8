Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F457C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 17:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446852073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 17:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgAQRcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:32:21 -0500
Received: from ms.lwn.net ([45.79.88.28]:51414 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgAQRcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 12:32:21 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4F1D1316;
        Fri, 17 Jan 2020 17:32:20 +0000 (UTC)
Date:   Fri, 17 Jan 2020 10:32:19 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 0/5] Documentation: nfs: convert remaining files to
 ReST.
Message-ID: <20200117103219.75de4b99@lwn.net>
In-Reply-To: <cover.1577681894.git.dwlsalmeida@gmail.com>
References: <cover.1577681894.git.dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Dec 2019 02:04:42 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> This series completes the conversion of Documentation/filesystems/nfs to ReST.

OK, I've made a quick pass through these.  They are mostly OK, with a
couple of exceptions.  One is that it has the "#." problem in enumerated
lists, which needs to be fixed as was done with the previous set.

And then there is:

> Note that I chose csv-table over list-table because csv files are easier
> to export from other software. 

That leads to results that look like this:

> +Operations
> +==========
> +
> +.. csv-table::
> +   :header: "Implementation status", "Operation", "REQ, REC, OPT or NMI", "Feature (REQ, REC or OPT)", "Definition"
> +   :widths: auto
> +   :delim: ;
> +
> +   ;"ACCESS";"REQ";;"Section 18.1"
> +   "I";"BACKCHANNEL_CTL";"REQ";;"Section 18.33"
> +   "I";"BIND_CONN_TO_SESSION";"REQ";;"Section 18.34"
> +   ;"CLOSE";"REQ";;"Section 18.2"
> +   ;"COMMIT";"REQ";;"Section 18.3"
> +   ;"CREATE";"REQ";;"Section 18.4"

...and that is essentially unreadable.  Remember that the plain-text
format matters too, so we can't do it this way.

The original is in something fairly close to the RST multicell table
format already; it shouldn't be too hard to add the tweaks needed to make
sphinx happy...?

Thanks,

jon
