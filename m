Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E33C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83A220885
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6PvtyVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHSRTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:19:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32717 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726715AbgHSRS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597857538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=930Y4wSeq8GeNMEyP0POAmpv0l8BHtYYHZC+5YI/u2M=;
        b=V6PvtyVpFzE2+zn0SAuwedugsLjvaAKoSSUcMAIjbQw5s7GKdo47ZAQ7b2xTL/czCB6qOC
        VcRGk4vZUjHxvkFP12pLj87WQ2lHnoZ46KhIX6CmSfR9wk/JqgN2psEPnrp16oHfAPAPmp
        CutRse8iraddp018CrDA+q9kdGGOlFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-IQl26hmhP7W4LkffKyg_jQ-1; Wed, 19 Aug 2020 13:18:56 -0400
X-MC-Unique: IQl26hmhP7W4LkffKyg_jQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00C258030A3;
        Wed, 19 Aug 2020 17:18:55 +0000 (UTC)
Received: from krava (unknown [10.40.192.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 56E3D5D9D5;
        Wed, 19 Aug 2020 17:18:50 +0000 (UTC)
Date:   Wed, 19 Aug 2020 19:18:49 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Nick Clifton <nickc@redhat.com>
Cc:     Mark Wielaard <mark@klomp.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>, sdf@google.com,
        andriin@fb.com
Subject: Re: Kernel build error on BTFIDS vmlinux
Message-ID: <20200819171820.GG177896@krava>
References: <20200818105555.51fc6d62@carbon>
 <20200818091404.GB177896@krava>
 <20200818105602.GC177896@krava>
 <20200818134543.GD177896@krava>
 <20200818183318.2c3fe4a2@carbon>
 <c9c4a42ba6b4d36e557a5441e90f7f4961ec3f72.camel@klomp.org>
 <0ddf7bc5-be05-cc06-05d7-2778c53d023b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ddf7bc5-be05-cc06-05d7-2778c53d023b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 04:34:30PM +0100, Nick Clifton wrote:
> Hi Mark,
> 
> > Adding Nick, the binutils maintainer, so we can make sure
> > binutils/elfutils agree on some ELF section compression corner case.
> 
> Thanks for doing this.
> 
> > But it would obviously be better if that wasn't necessary. So I'll try
> > to fix libelf so that if it fixes up the alignment when reading the
> > compressed data, it also does that when writing out the data again. But
> > that would only help for a new version of elfutils.
> > 
> > So it would be nice if binutils ld could also be fixed to write out
> > compressed sections with the correct alignment.
> 
> OK, I will look into doing this.
> 
> By any chance is there a small test case that you are using to check
> this behaviour ?   If so, please may I have a copy for myself ?

so when I take empty object and compile like:

  $ echo 'int main(int argc, char **argv) { return 0; }' | gcc -c -o ex.o -g -gz=zlib -x c -
  $ ld -o ex --compress-debug-sections=zlib ex.o

then there's .debug_info section that shows sh_addralign = 1
after I open the 'ex' obejct with elf_begin and iterate sections

according to Mark that should be 8 (on 64 bits)

when I change it to 8, the elf_update call won't fail for me
on that elf file

thanks,
jirka

