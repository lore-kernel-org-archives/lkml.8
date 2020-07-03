Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB82DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AFA72073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgGCJn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:43:56 -0400
Received: from smtprelay0019.hostedemail.com ([216.40.44.19]:41798 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725786AbgGCJnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:43:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 736CC182CF665;
        Fri,  3 Jul 2020 09:43:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: limit47_4e12c1126e90
X-Filterd-Recvd-Size: 2311
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Jul 2020 09:43:52 +0000 (UTC)
Message-ID: <2f1128bd916cebe01730528b5de47680d8721179.camel@perches.com>
Subject: Re: [PATCH 16/23] seq_file: switch over direct seq_read method
 calls to seq_read_iter
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Fri, 03 Jul 2020 02:43:51 -0700
In-Reply-To: <CANiq72=LekNWFbK8_+88T2oGSqA5A0fjnvn28cY-tEOfKbSqdw@mail.gmail.com>
References: <20200701200951.3603160-1-hch@lst.de>
         <20200701200951.3603160-17-hch@lst.de>
         <CANiq72=CaKKzXSayH9bRpzMkU2zyHGLA4a-XqTH--_mpTvO7ZQ@mail.gmail.com>
         <20200702135054.GA29240@lst.de>
         <CANiq72=8facdt7HBtoUZiJW5zfki-gYYESJzxjXf7wK7dYLm1Q@mail.gmail.com>
         <d7c902f9eecffc51f3a5761fa343bedad89dff7e.camel@perches.com>
         <CANiq72=LekNWFbK8_+88T2oGSqA5A0fjnvn28cY-tEOfKbSqdw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-03 at 11:35 +0200, Miguel Ojeda wrote:
> On Fri, Jul 3, 2020 at 9:44 AM Joe Perches <joe@perches.com> wrote:
> > And I'd generally not bother with 80 column rewrapping
> 
> Thanks for the quick answer Joe -- here I was referring to the cases
> where one needs to move all the `=`s to the right like:
> 
>  static const struct file_operations memtype_fops = {
>   .open    = memtype_seq_open,
> - .read    = seq_read,
> + .read_iter    = seq_read_iter,
>   .llseek  = seq_lseek,
>   .release = seq_release,
>  };
> 
> (I don't think there is any/many cases of 80-column rewrapping here).

OK.

I'm not much bothered much by alignments like that and
I don't see a good way to automate such conversions as
some might, as here, use spaces to align to = and most
would use tabs.




