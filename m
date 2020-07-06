Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E820C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1624C2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgGFM7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:59:12 -0400
Received: from smtprelay0048.hostedemail.com ([216.40.44.48]:47396 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729041AbgGFM7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:59:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B6C811AB01;
        Mon,  6 Jul 2020 12:59:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fact03_401811826eac
X-Filterd-Recvd-Size: 2574
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon,  6 Jul 2020 12:59:09 +0000 (UTC)
Message-ID: <d6f56f5f5e0790ee9c7579eb05c7d92e071ee15a.camel@perches.com>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy6545@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chris Mason <clm@fb.clm>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 06 Jul 2020 05:59:08 -0700
In-Reply-To: <CAFhKne9vswg3Q4mTOz4WP6QWJ8tDH+SNx1Pu7LotLagoNURKgw@mail.gmail.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
         <CAFhKne_ZVWVhZX5hNEbeGBfU6BMRN9JKQeTsVYOcMmEH1cd3xg@mail.gmail.com>
         <87h7ul15le.fsf@notabene.neil.brown.name>
         <20200706072221.GA1947246@kroah.com>
         <CAMuHMdWj2d5GF1ZkuhzQxg9teA51zjF0oQQPWcphzK=kJ6-x9Q@mail.gmail.com>
         <CAFhKne9vswg3Q4mTOz4WP6QWJ8tDH+SNx1Pu7LotLagoNURKgw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-06 at 08:51 -0400, Matthew Wilcox wrote:
[]
> In terms of number of lines of code using the word, it's only seventh
> in drivers/:
> 
> $ for i in drivers/*; do c=$(find $i -type f |xargs grep slave |wc
> -l); echo "$c $i"; done |sort -rn |head
> 5218 drivers/net
> 1341 drivers/dma
> 988 drivers/i2c
> 695 drivers/gpu
> 666 drivers/soundwire
> 665 drivers/spi
> 559 drivers/w1
> 461 drivers/infiniband
> 389 drivers/media
> 301 drivers/scsi

I get rather different and much lower numbers

$ git grep -i -w slave drivers | \
  cut -f1,2 -d/ | uniq -c | sort -rn | head -20 | cat -n
     1	   3091 drivers/net
     2	    654 drivers/i2c
     3	    595 drivers/soundwire
     4	    483 drivers/dma
     5	    284 drivers/infiniband
     6	    269 drivers/gpu
     7	    198 drivers/media
     8	    192 drivers/fsi
     9	    174 drivers/spi
    10	    131 drivers/ata
    11	    111 drivers/w1
    12	    110 drivers/staging
    13	     89 drivers/iio
    14	     71 drivers/usb
    15	     60 drivers/mfd
    16	     53 drivers/soc
    17	     52 drivers/tty
    18	     32 drivers/vme
    19	     32 drivers/mtd
    20	     28 drivers/ide


