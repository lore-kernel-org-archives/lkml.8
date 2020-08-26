Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B274C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA28E20707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598446828;
	bh=IWtrVErsNt6biC0nU1M0P0Qygjeyy2+q3KfSsdSxkWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ROAmbvj1joRPLV7K75l0HVLumMpkHOnX1KisHyOVu+EFE9Otg+iCgjQQXRL/f1ihS
	 y5J0a8GuQ8KLGc4CYFuADUFMKRubbq/+SCexvdlJmzPD424cKhUtuzyyYzGKntwB/g
	 c6+AjDz2Rgw/R0e91mFHzdPe+Wd+idSfOSh55BFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgHZNAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgHZNAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:00:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B7992080C;
        Wed, 26 Aug 2020 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598446805;
        bh=IWtrVErsNt6biC0nU1M0P0Qygjeyy2+q3KfSsdSxkWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wQEodM1+P3RE3vRwZe7NXLBYax59zSpUQettpNZkIZoxD716uYg5Y5dr9ygkgcHjM
         LWkQwKSuXf8I3r9R3XC4g3l++FvC9PSokP/AXKlm9mD65LGE8kl1GXp0xBjoONt9Zg
         7c1c2LddBk9KWYIuXi54lB7MgG0vUI3uuo0OOsxU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 46B4040D3D; Wed, 26 Aug 2020 10:00:03 -0300 (-03)
Date:   Wed, 26 Aug 2020 10:00:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf stat: Fix s390x compile error on F32
 utils/stat-display.c
Message-ID: <20200826130003.GE1059382@kernel.org>
References: <20200825063304.77733-1-tmricht@linux.ibm.com>
 <20200825071442.GB631468@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825071442.GB631468@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 25, 2020 at 09:14:42AM +0200, Jiri Olsa escreveu:
> On Tue, Aug 25, 2020 at 08:33:04AM +0200, Thomas Richter wrote:
> 
> SNIP
> 
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 57d0706e1330..cbe836649f84 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -117,12 +117,11 @@ static void aggr_printout(struct perf_stat_config *config,
> >  				cpu_map__id_to_die(id),
> >  				config->csv_output ? 0 : -3,
> >  				cpu_map__id_to_cpu(id), config->csv_sep);
> > -		} else {
> > +		} else if (id > -1)
> >  			fprintf(config->output, "CPU%*d%s",
> >  				config->csv_output ? 0 : -7,
> >  				evsel__cpus(evsel)->map[id],
> >  				config->csv_sep);
> > -		}
 
> I think we want multiple if lines within  { } but
> scripts/checkpatch.pl does not scream about this, so leaving this to
> Arnaldo ;-)

Yeah, I removed the removal of the {} for a multiline else block, added
your Acked-by, thanks,

- Analdo
 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> thanks,
> jirka
> 
> >  		break;
> >  	case AGGR_THREAD:
> >  		fprintf(config->output, "%*s-%*d%s",
> > -- 
> > 2.26.2
> > 
> 

-- 

- Arnaldo
