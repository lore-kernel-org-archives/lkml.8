Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD67C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F6520672
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bx/Zvoct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgGHSeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:34:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54631 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725879AbgGHSd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594233238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tVBi30FInY8NOiNU6S0x/u3is626GW6VT6IknU4Roxo=;
        b=Bx/ZvoctWwjx2sFIvJwa8Gu5SMf3A2rQ0O0xevnQAbWMxQhGgmwKPB36CrhLfBKiJe/nDn
        2cImb+4lncmS/KF7CLVjgF4ubpToTuEpKBoBq7Cnv6jyA0sFZFucRHONW/iotbc/ag+day
        b3Qde+gse+AJz/vn7z1O5P4t2HMEUJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-2L9V1PdlOVe62CEDTmfU5Q-1; Wed, 08 Jul 2020 14:33:55 -0400
X-MC-Unique: 2L9V1PdlOVe62CEDTmfU5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C131108BD11;
        Wed,  8 Jul 2020 18:33:54 +0000 (UTC)
Received: from krava (unknown [10.40.195.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52DC8C0084;
        Wed,  8 Jul 2020 18:33:52 +0000 (UTC)
Date:   Wed, 8 Jul 2020 20:33:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     =?iso-8859-1?Q?R=E9mi?= Bernon <rbernon@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jacek Caban <jacek@codeweavers.com>
Subject: Re: [PATCH 2/3] perf symbols: Try reading the symbol table with
 libbfd
Message-ID: <20200708183351.GB3581918@krava>
References: <20200624103041.825746-1-rbernon@codeweavers.com>
 <20200624103041.825746-2-rbernon@codeweavers.com>
 <20200624132545.GD2719003@krava>
 <8e8e5b2d-63e3-9feb-a21a-6bf355ce4013@codeweavers.com>
 <32a0da28-aca7-34b0-adb2-b0f61021fba8@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32a0da28-aca7-34b0-adb2-b0f61021fba8@codeweavers.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 11:44:24AM +0200, Rémi Bernon wrote:
> On 2020-06-24 15:40, Rémi Bernon wrote:
> > On 2020-06-24 15:25, Jiri Olsa wrote:
> > > On Wed, Jun 24, 2020 at 12:30:40PM +0200, Remi Bernon wrote:
> > > 
> > > SNIP
> > > 
> > > > +
> > > > +        symbols__insert(&dso->symbols, symbol);
> > > > +    }
> > > > +#ifdef bfd_get_section
> > > > +#undef bfd_asymbol_section
> > > > +#endif
> > > > +
> > > > +    symbols__fixup_end(&dso->symbols);
> > > > +    symbols__fixup_duplicate(&dso->symbols);
> > > > +    dso->adjust_symbols = 1;
> > > > +
> > > > +    err = 0;
> > > > +out_free:
> > > > +    free(symbols);
> > > > +out_close:
> > > > +    bfd_close(abfd);
> > > > +    return err;
> > > > +}
> > > > +#endif
> > > > +
> > > >   static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
> > > >                          enum dso_binary_type type)
> > > >   {
> > > > @@ -1695,6 +1816,7 @@ int dso__load(struct dso *dso, struct map *map)
> > > >           bool next_slot = false;
> > > >           bool is_reg;
> > > >           bool nsexit;
> > > > +        int bfdrc = -1;
> > > >           int sirc = -1;
> > > >           enum dso_binary_type symtab_type = binary_type_symtab[i];
> > > > @@ -1713,12 +1835,19 @@ int dso__load(struct dso *dso, struct map *map)
> > > >               nsinfo__mountns_exit(&nsc);
> > > >           is_reg = is_regular_file(name);
> > > > +#ifdef HAVE_LIBBFD_SUPPORT
> > > >           if (is_reg)
> > > > +            bfdrc = dso__load_bfd_symbols(dso, name);
> > > > +#endif
> > > 
> > > so the comment says that we try bfd when the libelf fails,
> > > but the code seems to do the oposite.. starts with bfd
> > > and skip libelf if it's ok
> > > 
> > > jirka
> > > 
> > 
> > Ah, sorry I forgot to reword the commit comment to match the changes,
> > thanks for noticing. It should probably be something like that:
> > 
> >    Trying to read symbols on non-ELF binaries with libbfd, when
> >    supported, makes it possible for perf to report symbols and
> >    annotations for Windows applications running under Wine.
> > 
> > As you suggested, the libbfd code now tries to detect the binary format,
> >  and early rejects if ELF is detected, so it then falls back to the
> > libelf code path.
> 
> Hi, it doesn't seem there's more comments, should I just resend the series
> with the updated commit message?

yes, please fix the changelog..  patches look good to me, but
I'd like somebody else with better bfd knowledge to review them ;-)

jirka

