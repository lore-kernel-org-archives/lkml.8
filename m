Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907B1C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3AA206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LD++SuMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgCWBEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 21:04:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58163 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726916AbgCWBEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 21:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584925483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aG1HR6vnX9d/puzieVgxoR5+qeHzgld0YjOlInXM12g=;
        b=LD++SuMv10RwYBDj1gQIezbJWyURhrso8rcrcNwZmBJcTC454eEXcY+duP3bQmGd0vIzJD
        wTj/6PwpTmRYPsgwbTMU1hbVJSIiXD0SQNrutBXVSC+crVAsXoe8ISLcPXIwn7P15GzE9S
        ba0aLQoG/D8Nz9TEZBdjq+2M/un9cFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-gkMjLTdKPYCXVIHRwbB7lA-1; Sun, 22 Mar 2020 21:04:40 -0400
X-MC-Unique: gkMjLTdKPYCXVIHRwbB7lA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25360107ACCC;
        Mon, 23 Mar 2020 01:04:38 +0000 (UTC)
Received: from elisabeth (unknown [10.40.208.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E23960BF1;
        Mon, 23 Mar 2020 01:04:33 +0000 (UTC)
Date:   Mon, 23 Mar 2020 02:04:25 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH 01/11] Staging: rtl8188eu: hal_com:
 Add space around operators
Message-ID: <20200323020425.62dbeebb@elisabeth>
In-Reply-To: <f2b4f7f38a8a490ffc917f7199099ac95656c8c2.camel@gmail.com>
References: <cover.1584826154.git.shreeya.patel23498@gmail.com>
        <19950c71482b3be0dd9518398af85e964f3b66b1.1584826154.git.shreeya.patel23498@gmail.com>
        <20200322112744.GC75383@kroah.com>
        <e40d49aaa96a61019804255c2990d229b2eef7dc.camel@perches.com>
        <f2b4f7f38a8a490ffc917f7199099ac95656c8c2.camel@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shreeya,

On Mon, 23 Mar 2020 04:48:08 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> On Sun, 2020-03-22 at 08:09 -0700, Joe Perches wrote:
> > On Sun, 2020-03-22 at 12:27 +0100, Greg KH wrote:  
> 
> Hi Greg and Joe,
> 
> > > On Sun, Mar 22, 2020 at 03:51:13AM +0530, Shreeya Patel wrote:  
> > > > Add space around operators for improving the code
> > > > readability.
> > > > Reported by checkpatch.pl
> > > > 
> > > > git diff -w shows no difference.
> > > > diff of the .o files before and after the changes shows no
> > > > difference.  
> > > 
> > > There is no need to have these two lines on every changelog comment
> > > in
> > > this series :(  
> >   
> Yes I get that.
> 
> > In my opinion, there's no need for a series here.
> > 
> > Whitespace only changes _should_ be done all at once.
> > 
> > Whitespace changes _could_ have changed string constants.
> > 
> > So noting that the patch in only whitespace and that
> > there isn't a difference in object files is useful as
> > it shows any change has been compiled and tested.
> >   
> 
> Joe, I feel the same thing, there is no need of a patch series
> for it but I was given a suggestion that it becomes difficult for the
> reviewers to review the patch so it is good to send a patchset instead.

In this case, reviewing the 224 lines you're touching in one shot feels
the same as reviewing them over 11 patches, as the change is always of
the same type. Maybe a single patch is actually even a bit quicker to
review.

Are you sure the suggestion was referring to this, and it wasn't about
different type of changes in the same patch?

-- 
Stefano

