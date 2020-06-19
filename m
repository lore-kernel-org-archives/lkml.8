Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEC4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D062080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbgFSLJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:09:01 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48597 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732362AbgFSLJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:09:01 -0400
X-Originating-IP: 82.255.60.242
Received: from classic (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A13FDE0003;
        Fri, 19 Jun 2020 11:08:54 +0000 (UTC)
Message-ID: <f57cd2a9a27fb148f0bdfd0ad5e92b4d01ca77c6.camel@hadess.net>
Subject: Re: [PATCH 1/8] USB: rename USB quirk to USB_QUIRK_ENDPOINT_IGNORE
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Richard Dodd <richard.o.dodd@gmail.com>,
        Jonathan Cox <jonathan@jdcox.net>,
        =?ISO-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>
Date:   Fri, 19 Jun 2020 13:08:53 +0200
In-Reply-To: <62b8ddc4-8d26-1160-6934-fe6a68231938@redhat.com>
References: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
         <20200618094300.1887727-2-gregkh@linuxfoundation.org>
         <484c84b62140f6536f841e7027ddd9ddcf179a72.camel@hadess.net>
         <62b8ddc4-8d26-1160-6934-fe6a68231938@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-19 at 12:53 +0200, Hans de Goede wrote:
> A note for future reference, not sure what you mean with driver
> 
> API here. If you mean the in kernel API, the kernel rules are
> 
> that we are always free to change that (Linux does not have a
> 
> stable driver API).
> 
> 
> 
> So if a header does not sit under include/uapi (indicating that
> 
> it is an userspace API) then a change like this is fine.

I meant the internal driver API, which might break out-of-tree drivers.
I know that this API is fluid, and that there are no stability
guarantees, but I'd still expect at least a note in the commit message
to that effect.

