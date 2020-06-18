Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B8BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501FC2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOvAIArN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgFRIoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:44:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48202 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728504AbgFRIoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592469839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cmam5x4vymyw2Jjm/tFzm/1LYmex0HjXC9qi5eV1gJ8=;
        b=OOvAIArNSvLUGY2CXOKboSWCivgIXGWwKazG/Um7+b3FHchFIJrCKRnnGs/SeLOG6pR2Rv
        w7Re/59KKw1FDHP5rtoaSNxvSlGXamy0wNkcLzYPjAmPlSENcrnKQKI52x+t+2kc4SIDrb
        d8w+dXq3R6YioCThILlDU1iiOJHB1Ks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-UuYIujFBMfKmS2z6P6oDvw-1; Thu, 18 Jun 2020 04:43:55 -0400
X-MC-Unique: UuYIujFBMfKmS2z6P6oDvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BEBF835B41;
        Thu, 18 Jun 2020 08:43:53 +0000 (UTC)
Received: from carbon (unknown [10.40.208.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF75419730;
        Thu, 18 Jun 2020 08:43:45 +0000 (UTC)
Date:   Thu, 18 Jun 2020 10:43:44 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, brouer@redhat.com
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Message-ID: <20200618104344.6a96ac04@carbon>
In-Reply-To: <20200618012928.GD24694@carbon.DHCP.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
        <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
        <20200617024147.GA10812@carbon.lan>
        <CALvZod4vLQb4kns=ao8btL_g--9axZfcaxhMnj+CoTrCkyWoWQ@mail.gmail.com>
        <20200617033217.GE10812@carbon.lan>
        <e510e964-2703-d123-120c-816bbdd35743@suse.cz>
        <20200618012928.GD24694@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 18:29:28 -0700
Roman Gushchin <guro@fb.com> wrote:

> On Wed, Jun 17, 2020 at 01:24:21PM +0200, Vlastimil Babka wrote:
> > On 6/17/20 5:32 AM, Roman Gushchin wrote:  
> > > On Tue, Jun 16, 2020 at 08:05:39PM -0700, Shakeel Butt wrote:  
> > >> On Tue, Jun 16, 2020 at 7:41 PM Roman Gushchin <guro@fb.com> wrote:  
> > >> >
> > >> > On Tue, Jun 16, 2020 at 06:46:56PM -0700, Shakeel Butt wrote:  
> > >> > > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:  
> > >> > > >  
> > >> [...]  
> > >> > >
> > >> > > Have you performed any [perf] testing on SLAB with this patchset?  
> > >> >
> > >> > The accounting part is the same for SLAB and SLUB, so there should be no
> > >> > significant difference. I've checked that it compiles, boots and passes
> > >> > kselftests. And that memory savings are there.
> > >> >  
> > >> 
> > >> What about performance? Also you mentioned that sharing kmem-cache
> > >> between accounted and non-accounted can have additional overhead. Any
> > >> difference between SLAB and SLUB for such a case?  
> > > 
> > > Not really.
> > > 
> > > Sharing a single set of caches adds some overhead to root- and non-accounted
> > > allocations, which is something I've tried hard to avoid in my original version.
> > > But I have to admit, it allows to simplify and remove a lot of code, and here
> > > it's hard to argue with Johanness, who pushed on this design.
> > > 
> > > With performance testing it's not that easy, because it's not obvious what
> > > we wanna test. Obviously, per-object accounting is more expensive, and
> > > measuring something like 1000000 allocations and deallocations in a line from
> > > a single kmem_cache will show a regression. But in the real world the relative
> > > cost of allocations is usually low, and we can get some benefits from a smaller
> > > working set and from having shared kmem_cache objects cache hot.
> > > Not speaking about some extra memory and the fragmentation reduction.
> > > 
> > > We've done an extensive testing of the original version in Facebook production,
> > > and we haven't noticed any regressions so far. But I have to admit, we were
> > > using an original version with two sets of kmem_caches.
> > > 
> > > If you have any specific tests in mind, I can definitely run them. Or if you
> > > can help with the performance evaluation, I'll appreciate it a lot.  
> > 
> > Jesper provided some pointers here [1], it would be really great if you could
> > run at least those microbenchmarks. With mmtests it's the major question of
> > which subset/profiles to run, maybe the referenced commits provide some hints,
> > or maybe Mel could suggest what he used to evaluate SLAB vs SLUB not so long ago.
> > 
> > [1] https://lore.kernel.org/linux-mm/20200527103545.4348ac10@carbon/  
> 
> Oh, Jesper, I'm really sorry, somehow I missed your mail.
> Thank you, Vlastimil, for pointing at it.
> 
> I've got some results (slab_bulk_test01), but honestly I fail to interpret them.
> 
> I ran original vs patched with SLUB and SLAB, each test several times and picked
> 3 which looked most consistently. But it still looks very noisy.
> 
> I ran them on my desktop (8-core Ryzen 1700, 16 GB RAM, Fedora 32),
> it's 5.8-rc1 + slab controller v6 vs 5.8-rc1 (default config from Fedora 32).

What about running these tests on the server level hardware, that you
intent to run this on?  

> 
> How should I interpret this data?

First of all these SLUB+SLAB microbenchmarks use object size 256 bytes,
because network stack alloc object of this size for SKBs/sk_buff (due
to cache-align as used size is 224 bytes). Checked SLUB: Each slab use
2 pages (8192 bytes) and contain 32 object of size 256 (256*32=8192).

  The SLUB allocator have a per-CPU slab which speedup fast-reuse, in this
case up-to 32 objects. For SLUB the "fastpath reuse" test this behaviour,
and it serves as a baseline for optimal 1-object performance (where my bulk
API tries to beat that, which is possible even for 1-object due to knowing
bulk API cannot be used from IRQ context).

SLUB fastpath: 3 measurements reporting cycles(tsc)
 - SLUB-patched : fastpath reuse: 184 - 177 - 176  cycles(tsc)
 - SLUB-original: fastpath reuse: 178 - 153 - 156  cycles(tsc)

There are some stability concerns as you mention, but it seems pretty
consistently that patched version is slower. If you compile with
no-PREEMPT you can likely get more stable results (and remove a slight
overhead for SLUB fastpath).

The microbenchmark also measures the bulk-API, which is AFAIK only used
by network stack (and io_uring). I guess you shouldn't focus too much
on these bulk measurements. When bulk-API cross this objects per slab
threshold, or is unlucky is it use two per-CPU slab, then the
measurements can fluctuate a bit.

Your numbers for SLUB bulk-API:

SLUB-patched - bulk-API
 - SLUB-patched : bulk_quick_reuse objects=1 : 187 -  90 - 224  cycles(tsc)
 - SLUB-patched : bulk_quick_reuse objects=2 : 110 -  53 - 133  cycles(tsc)
 - SLUB-patched : bulk_quick_reuse objects=3 :  88 -  95 -  42  cycles(tsc)
 - SLUB-patched : bulk_quick_reuse objects=4 :  91 -  85 -  36  cycles(tsc)
 - SLUB-patched : bulk_quick_reuse objects=8 :  32 -  66 -  32  cycles(tsc)

SLUB-original -  bulk-API
 - SLUB-original: bulk_quick_reuse objects=1 :  87 -  87 - 142  cycles(tsc)
 - SLUB-original: bulk_quick_reuse objects=2 :  52 -  53 -  53  cycles(tsc)
 - SLUB-original: bulk_quick_reuse objects=3 :  42 -  42 -  91  cycles(tsc)
 - SLUB-original: bulk_quick_reuse objects=4 :  91 -  37 -  37  cycles(tsc)
 - SLUB-original: bulk_quick_reuse objects=8 :  31 -  79 -  76  cycles(tsc)

Maybe it is just noise or instability in measurements, but it seem that the
1-object case is consistently slower in your patched version.

Mail is too long now... I'll take a look at your SLAB results and followup.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

 
> --
> 
> SLUB:
> 
> Patched:
> [  444.395174] time_bench: Type:for_loop Per elem: 2 cycles(tsc) 0.773 ns (step:0) - (measurement period time:0.077335091 sec time_interval:77335091) - (invoke count:100000000 tsc_interval:231555960)
> [  445.012669] time_bench: Type:kmem fastpath reuse Per elem: 184 cycles(tsc) 61.747 ns (step:0) - (measurement period time:0.617475365 sec time_interval:617475365) - (invoke count:10000000 tsc_interval:1848850440)
> [  445.703843] time_bench: Type:kmem bulk_fallback Per elem: 206 cycles(tsc) 69.115 ns (step:1) - (measurement period time:0.691150675 sec time_interval:691150675) - (invoke count:10000000 tsc_interval:2069450250)
> [  446.329396] time_bench: Type:kmem bulk_quick_reuse Per elem: 187 cycles(tsc) 62.554 ns (step:1) - (measurement period time:0.625541838 sec time_interval:625541838) - (invoke count:10000000 tsc_interval:1873003020)
> [  446.975616] time_bench: Type:kmem bulk_fallback Per elem: 193 cycles(tsc) 64.622 ns (step:2) - (measurement period time:0.646223732 sec time_interval:646223732) - (invoke count:10000000 tsc_interval:1934929440)
> [  447.345512] time_bench: Type:kmem bulk_quick_reuse Per elem: 110 cycles(tsc) 36.988 ns (step:2) - (measurement period time:0.369885352 sec time_interval:369885352) - (invoke count:10000000 tsc_interval:1107514050)
> [  447.986272] time_bench: Type:kmem bulk_fallback Per elem: 191 cycles(tsc) 64.075 ns (step:3) - (measurement period time:0.640756304 sec time_interval:640756304) - (invoke count:9999999 tsc_interval:1918559070)
> [  448.282163] time_bench: Type:kmem bulk_quick_reuse Per elem: 88 cycles(tsc) 29.586 ns (step:3) - (measurement period time:0.295866328 sec time_interval:295866328) - (invoke count:9999999 tsc_interval:885885270)
> [  448.623183] time_bench: Type:kmem bulk_fallback Per elem: 102 cycles(tsc) 34.100 ns (step:4) - (measurement period time:0.341005290 sec time_interval:341005290) - (invoke count:10000000 tsc_interval:1021040820)
> [  448.930228] time_bench: Type:kmem bulk_quick_reuse Per elem: 91 cycles(tsc) 30.702 ns (step:4) - (measurement period time:0.307020500 sec time_interval:307020500) - (invoke count:10000000 tsc_interval:919282860)
> [  449.739697] time_bench: Type:kmem bulk_fallback Per elem: 242 cycles(tsc) 80.946 ns (step:8) - (measurement period time:0.809465825 sec time_interval:809465825) - (invoke count:10000000 tsc_interval:2423710560)
> [  449.848110] time_bench: Type:kmem bulk_quick_reuse Per elem: 32 cycles(tsc) 10.836 ns (step:8) - (measurement period time:0.108363638 sec time_interval:108363638) - (invoke count:10000000 tsc_interval:324462540)
> [  450.617892] time_bench: Type:kmem bulk_fallback Per elem: 230 cycles(tsc) 76.978 ns (step:16) - (measurement period time:0.769783892 sec time_interval:769783892) - (invoke count:10000000 tsc_interval:2304894090)
> [  450.719556] time_bench: Type:kmem bulk_quick_reuse Per elem: 30 cycles(tsc) 10.164 ns (step:16) - (measurement period time:0.101645837 sec time_interval:101645837) - (invoke count:10000000 tsc_interval:304348440)
> [  451.025387] time_bench: Type:kmem bulk_fallback Per elem: 91 cycles(tsc) 30.580 ns (step:30) - (measurement period time:0.305803321 sec time_interval:305803321) - (invoke count:9999990 tsc_interval:915639450)
> [  451.277708] time_bench: Type:kmem bulk_quick_reuse Per elem: 75 cycles(tsc) 25.229 ns (step:30) - (measurement period time:0.252294821 sec time_interval:252294821) - (invoke count:9999990 tsc_interval:755422110)
> [  451.709305] time_bench: Type:kmem bulk_fallback Per elem: 129 cycles(tsc) 43.158 ns (step:32) - (measurement period time:0.431581619 sec time_interval:431581619) - (invoke count:10000000 tsc_interval:1292245320)
> [  451.810686] time_bench: Type:kmem bulk_quick_reuse Per elem: 30 cycles(tsc) 10.135 ns (step:32) - (measurement period time:0.101357841 sec time_interval:101357841) - (invoke count:10000000 tsc_interval:303485250)
> [  452.186138] time_bench: Type:kmem bulk_fallback Per elem: 112 cycles(tsc) 37.545 ns (step:34) - (measurement period time:0.375453243 sec time_interval:375453243) - (invoke count:9999978 tsc_interval:1124185320)
> [  452.304950] time_bench: Type:kmem bulk_quick_reuse Per elem: 35 cycles(tsc) 11.880 ns (step:34) - (measurement period time:0.118800736 sec time_interval:118800736) - (invoke count:9999978 tsc_interval:355713360)
> [  452.658607] time_bench: Type:kmem bulk_fallback Per elem: 105 cycles(tsc) 35.362 ns (step:48) - (measurement period time:0.353623065 sec time_interval:353623065) - (invoke count:9999984 tsc_interval:1058820960)
> [  452.891623] time_bench: Type:kmem bulk_quick_reuse Per elem: 69 cycles(tsc) 23.298 ns (step:48) - (measurement period time:0.232988291 sec time_interval:232988291) - (invoke count:9999984 tsc_interval:697614570)
> [  453.237406] time_bench: Type:kmem bulk_fallback Per elem: 103 cycles(tsc) 34.578 ns (step:64) - (measurement period time:0.345780444 sec time_interval:345780444) - (invoke count:10000000 tsc_interval:1035338790)
> [  453.344946] time_bench: Type:kmem bulk_quick_reuse Per elem: 32 cycles(tsc) 10.750 ns (step:64) - (measurement period time:0.107500964 sec time_interval:107500964) - (invoke count:10000000 tsc_interval:321880290)
> [  454.249297] time_bench: Type:kmem bulk_fallback Per elem: 270 cycles(tsc) 90.434 ns (step:128) - (measurement period time:0.904340126 sec time_interval:904340126) - (invoke count:10000000 tsc_interval:2707784610)
> [  454.582548] time_bench: Type:kmem bulk_quick_reuse Per elem: 99 cycles(tsc) 33.322 ns (step:128) - (measurement period time:0.333226211 sec time_interval:333226211) - (invoke count:10000000 tsc_interval:997748760)
> [  454.965002] time_bench: Type:kmem bulk_fallback Per elem: 114 cycles(tsc) 38.241 ns (step:158) - (measurement period time:0.382415227 sec time_interval:382415227) - (invoke count:9999978 tsc_interval:1145031120)
> [  455.314105] time_bench: Type:kmem bulk_quick_reuse Per elem: 104 cycles(tsc) 34.908 ns (step:158) - (measurement period time:0.349080430 sec time_interval:349080430) - (invoke count:9999978 tsc_interval:1045219530)
> [  455.699089] time_bench: Type:kmem bulk_fallback Per elem: 115 cycles(tsc) 38.495 ns (step:250) - (measurement period time:0.384953654 sec time_interval:384953654) - (invoke count:10000000 tsc_interval:1152631920)
> [  456.104244] time_bench: Type:kmem bulk_quick_reuse Per elem: 121 cycles(tsc) 40.513 ns (step:250) - (measurement period time:0.405138149 sec time_interval:405138149) - (invoke count:10000000 tsc_interval:1213068180)
> 
> [  465.696654] time_bench: Type:for_loop Per elem: 2 cycles(tsc) 0.772 ns (step:0) - (measurement period time:0.077270577 sec time_interval:77270577) - (invoke count:100000000 tsc_interval:231363840)
> [  466.290176] time_bench: Type:kmem fastpath reuse Per elem: 177 cycles(tsc) 59.349 ns (step:0) - (measurement period time:0.593496780 sec time_interval:593496780) - (invoke count:10000000 tsc_interval:1777053420)
> [  466.629838] time_bench: Type:kmem bulk_fallback Per elem: 101 cycles(tsc) 33.965 ns (step:1) - (measurement period time:0.339652351 sec time_interval:339652351) - (invoke count:10000000 tsc_interval:1016989230)
> [  466.933290] time_bench: Type:kmem bulk_quick_reuse Per elem: 90 cycles(tsc) 30.344 ns (step:1) - (measurement period time:0.303444180 sec time_interval:303444180) - (invoke count:10000000 tsc_interval:908575380)
> [  467.250189] time_bench: Type:kmem bulk_fallback Per elem: 94 cycles(tsc) 31.689 ns (step:2) - (measurement period time:0.316896073 sec time_interval:316896073) - (invoke count:10000000 tsc_interval:948853110)
> [  467.430142] time_bench: Type:kmem bulk_quick_reuse Per elem: 53 cycles(tsc) 17.994 ns (step:2) - (measurement period time:0.179940800 sec time_interval:179940800) - (invoke count:10000000 tsc_interval:538779390)
> [  467.780573] time_bench: Type:kmem bulk_fallback Per elem: 104 cycles(tsc) 35.039 ns (step:3) - (measurement period time:0.350394226 sec time_interval:350394226) - (invoke count:9999999 tsc_interval:1049153580)
> [  468.100301] time_bench: Type:kmem bulk_quick_reuse Per elem: 95 cycles(tsc) 31.970 ns (step:3) - (measurement period time:0.319706687 sec time_interval:319706687) - (invoke count:9999999 tsc_interval:957267660)
> [  468.792650] time_bench: Type:kmem bulk_fallback Per elem: 207 cycles(tsc) 69.235 ns (step:4) - (measurement period time:0.692354598 sec time_interval:692354598) - (invoke count:10000000 tsc_interval:2073054750)
> [  469.078816] time_bench: Type:kmem bulk_quick_reuse Per elem: 85 cycles(tsc) 28.614 ns (step:4) - (measurement period time:0.286145162 sec time_interval:286145162) - (invoke count:10000000 tsc_interval:856777710)
> [  469.694558] time_bench: Type:kmem bulk_fallback Per elem: 184 cycles(tsc) 61.573 ns (step:8) - (measurement period time:0.615733224 sec time_interval:615733224) - (invoke count:10000000 tsc_interval:1843634190)
> [  469.917439] time_bench: Type:kmem bulk_quick_reuse Per elem: 66 cycles(tsc) 22.284 ns (step:8) - (measurement period time:0.222848937 sec time_interval:222848937) - (invoke count:10000000 tsc_interval:667255740)
> [  470.586966] time_bench: Type:kmem bulk_fallback Per elem: 200 cycles(tsc) 66.952 ns (step:16) - (measurement period time:0.669526473 sec time_interval:669526473) - (invoke count:10000000 tsc_interval:2004702960)
> [  470.794012] time_bench: Type:kmem bulk_quick_reuse Per elem: 61 cycles(tsc) 20.697 ns (step:16) - (measurement period time:0.206972335 sec time_interval:206972335) - (invoke count:10000000 tsc_interval:619717170)
> [  471.422674] time_bench: Type:kmem bulk_fallback Per elem: 188 cycles(tsc) 62.866 ns (step:30) - (measurement period time:0.628659634 sec time_interval:628659634) - (invoke count:9999990 tsc_interval:1882338990)
> [  471.524193] time_bench: Type:kmem bulk_quick_reuse Per elem: 30 cycles(tsc) 10.149 ns (step:30) - (measurement period time:0.101497972 sec time_interval:101497972) - (invoke count:9999990 tsc_interval:303905340)
> [  471.829474] time_bench: Type:kmem bulk_fallback Per elem: 91 cycles(tsc) 30.527 ns (step:32) - (measurement period time:0.305271485 sec time_interval:305271485) - (invoke count:10000000 tsc_interval:914046510)
> [  471.930490] time_bench: Type:kmem bulk_quick_reuse Per elem: 30 cycles(tsc) 10.099 ns (step:32) - (measurement period time:0.100992877 sec time_interval:100992877) - (invoke count:10000000 tsc_interval:302392890)
> [  472.311211] time_bench: Type:kmem bulk_fallback Per elem: 113 cycles(tsc) 38.072 ns (step:34) - (measurement period time:0.380725777 sec time_interval:380725777) - (invoke count:9999978 tsc_interval:1139972850)
> [  472.429823] time_bench: Type:kmem bulk_quick_reuse Per elem: 35 cycles(tsc) 11.860 ns (step:34) - (measurement period time:0.118599617 sec time_interval:118599617) - (invoke count:9999978 tsc_interval:355111890)
> [  472.890092] time_bench: Type:kmem bulk_fallback Per elem: 137 cycles(tsc) 46.026 ns (step:48) - (measurement period time:0.460264730 sec time_interval:460264730) - (invoke count:9999984 tsc_interval:1378127970)
> [  472.999481] time_bench: Type:kmem bulk_quick_reuse Per elem: 32 cycles(tsc) 10.937 ns (step:48) - (measurement period time:0.109371593 sec time_interval:109371593) - (invoke count:9999984 tsc_interval:327480390)
> [  473.344109] time_bench: Type:kmem bulk_fallback Per elem: 103 cycles(tsc) 34.462 ns (step:64) - (measurement period time:0.344629774 sec time_interval:344629774) - (invoke count:10000000 tsc_interval:1031893740)
> [  473.452099] time_bench: Type:kmem bulk_quick_reuse Per elem: 32 cycles(tsc) 10.794 ns (step:64) - (measurement period time:0.107942846 sec time_interval:107942846) - (invoke count:10000000 tsc_interval:323202390)
> [  474.382899] time_bench: Type:kmem bulk_fallback Per elem: 278 cycles(tsc) 93.080 ns (step:128) - (measurement period time:0.930809025 sec time_interval:930809025) - (invoke count:10000000 tsc_interval:2787037260)
> [  474.729757] time_bench: Type:kmem bulk_quick_reuse Per elem: 103 cycles(tsc) 34.683 ns (step:128) - (measurement period time:0.346831572 sec time_interval:346831572) - (invoke count:10000000 tsc_interval:1038484980)
> [  475.616707] time_bench: Type:kmem bulk_fallback Per elem: 265 cycles(tsc) 88.693 ns (step:158) - (measurement period time:0.886937188 sec time_interval:886937188) - (invoke count:9999978 tsc_interval:2655675660)
> [  475.890425] time_bench: Type:kmem bulk_quick_reuse Per elem: 81 cycles(tsc) 27.369 ns (step:158) - (measurement period time:0.273692416 sec time_interval:273692416) - (invoke count:9999978 tsc_interval:819491040)
> [  476.275144] time_bench: Type:kmem bulk_fallback Per elem: 115 cycles(tsc) 38.471 ns (step:250) - (measurement period time:0.384713160 sec time_interval:384713160) - (invoke count:10000000 tsc_interval:1151911110)
> [  476.424219] time_bench: Type:kmem bulk_quick_reuse Per elem: 44 cycles(tsc) 14.906 ns (step:250) - (measurement period time:0.149068364 sec time_interval:149068364) - (invoke count:10000000 tsc_interval:446341830)
> 
> [  490.306824] time_bench: Type:for_loop Per elem: 2 cycles(tsc) 0.776 ns (step:0) - (measurement period time:0.077691991 sec time_interval:77691991) - (invoke count:100000000 tsc_interval:232625850)
> [  490.897035] time_bench: Type:kmem fastpath reuse Per elem: 176 cycles(tsc) 59.019 ns (step:0) - (measurement period time:0.590195120 sec time_interval:590195120) - (invoke count:10000000 tsc_interval:1767174930)
> [  491.590675] time_bench: Type:kmem bulk_fallback Per elem: 207 cycles(tsc) 69.362 ns (step:1) - (measurement period time:0.693628128 sec time_interval:693628128) - (invoke count:10000000 tsc_interval:2076877050)
> [  492.339461] time_bench: Type:kmem bulk_quick_reuse Per elem: 224 cycles(tsc) 74.877 ns (step:1) - (measurement period time:0.748777171 sec time_interval:748777171) - (invoke count:10000000 tsc_interval:2242005540)
> [  493.129328] time_bench: Type:kmem bulk_fallback Per elem: 236 cycles(tsc) 78.984 ns (step:2) - (measurement period time:0.789848781 sec time_interval:789848781) - (invoke count:10000000 tsc_interval:2364983220)
> [  493.574670] time_bench: Type:kmem bulk_quick_reuse Per elem: 133 cycles(tsc) 44.530 ns (step:2) - (measurement period time:0.445304096 sec time_interval:445304096) - (invoke count:10000000 tsc_interval:1333339110)
> [  493.887021] time_bench: Type:kmem bulk_fallback Per elem: 93 cycles(tsc) 31.231 ns (step:3) - (measurement period time:0.312316389 sec time_interval:312316389) - (invoke count:9999999 tsc_interval:935143950)
> [  494.029383] time_bench: Type:kmem bulk_quick_reuse Per elem: 42 cycles(tsc) 14.234 ns (step:3) - (measurement period time:0.142346254 sec time_interval:142346254) - (invoke count:9999999 tsc_interval:426216000)
> [  494.369892] time_bench: Type:kmem bulk_fallback Per elem: 101 cycles(tsc) 34.050 ns (step:4) - (measurement period time:0.340504527 sec time_interval:340504527) - (invoke count:10000000 tsc_interval:1019546130)
> [  494.493217] time_bench: Type:kmem bulk_quick_reuse Per elem: 36 cycles(tsc) 12.329 ns (step:4) - (measurement period time:0.123294475 sec time_interval:123294475) - (invoke count:10000000 tsc_interval:369169800)
> [  494.820003] time_bench: Type:kmem bulk_fallback Per elem: 97 cycles(tsc) 32.678 ns (step:8) - (measurement period time:0.326780876 sec time_interval:326780876) - (invoke count:10000000 tsc_interval:978453960)
> [  494.928831] time_bench: Type:kmem bulk_quick_reuse Per elem: 32 cycles(tsc) 10.880 ns (step:8) - (measurement period time:0.108808086 sec time_interval:108808086) - (invoke count:10000000 tsc_interval:325794570)
> [  495.684358] time_bench: Type:kmem bulk_fallback Per elem: 226 cycles(tsc) 75.552 ns (step:16) - (measurement period time:0.755527917 sec time_interval:755527917) - (invoke count:10000000 tsc_interval:2262218520)
> [  495.785682] time_bench: Type:kmem bulk_quick_reuse Per elem: 30 cycles(tsc) 10.130 ns (step:16) - (measurement period time:0.101307607 sec time_interval:101307607) - (invoke count:10000000 tsc_interval:303336720)
> [  496.090994] time_bench: Type:kmem bulk_fallback Per elem: 91 cycles(tsc) 30.528 ns (step:30) - (measurement period time:0.305280433 sec time_interval:305280433) - (invoke count:9999990 tsc_interval:914077290)
> [  496.341570] time_bench: Type:kmem bulk_quick_reuse Per elem: 75 cycles(tsc) 25.054 ns (step:30) - (measurement period time:0.250548825 sec time_interval:250548825) - (invoke count:9999990 tsc_interval:750197910)
> [  496.646784] time_bench: Type:kmem bulk_fallback Per elem: 91 cycles(tsc) 30.518 ns (step:32) - (measurement period time:0.305189218 sec time_interval:305189218) - (invoke count:10000000 tsc_interval:913803540)
> [  496.900311] time_bench: Type:kmem bulk_quick_reuse Per elem: 75 cycles(tsc) 25.349 ns (step:32) - (measurement period time:0.253499465 sec time_interval:253499465) - (invoke count:10000000 tsc_interval:759033060)
> [  497.778600] time_bench: Type:kmem bulk_fallback Per elem: 262 cycles(tsc) 87.830 ns (step:34) - (measurement period time:0.878298604 sec time_interval:878298604) - (invoke count:9999978 tsc_interval:2629821090)
> [  498.043690] time_bench: Type:kmem bulk_quick_reuse Per elem: 79 cycles(tsc) 26.506 ns (step:34) - (measurement period time:0.265066374 sec time_interval:265066374) - (invoke count:9999978 tsc_interval:793667400)
> [  498.393912] time_bench: Type:kmem bulk_fallback Per elem: 104 cycles(tsc) 35.021 ns (step:48) - (measurement period time:0.350216735 sec time_interval:350216735) - (invoke count:9999984 tsc_interval:1048626840)
> [  498.504846] time_bench: Type:kmem bulk_quick_reuse Per elem: 33 cycles(tsc) 11.092 ns (step:48) - (measurement period time:0.110924201 sec time_interval:110924201) - (invoke count:9999984 tsc_interval:332131200)
> [  498.878335] time_bench: Type:kmem bulk_fallback Per elem: 111 cycles(tsc) 37.345 ns (step:64) - (measurement period time:0.373454272 sec time_interval:373454272) - (invoke count:10000000 tsc_interval:1118205060)
> [  499.145467] time_bench: Type:kmem bulk_quick_reuse Per elem: 79 cycles(tsc) 26.710 ns (step:64) - (measurement period time:0.267102714 sec time_interval:267102714) - (invoke count:10000000 tsc_interval:799763910)
> [  499.525255] time_bench: Type:kmem bulk_fallback Per elem: 113 cycles(tsc) 37.971 ns (step:128) - (measurement period time:0.379715035 sec time_interval:379715035) - (invoke count:10000000 tsc_interval:1136951190)
> [  499.852495] time_bench: Type:kmem bulk_quick_reuse Per elem: 97 cycles(tsc) 32.721 ns (step:128) - (measurement period time:0.327218329 sec time_interval:327218329) - (invoke count:10000000 tsc_interval:979763670)
> [  500.238889] time_bench: Type:kmem bulk_fallback Per elem: 115 cycles(tsc) 38.638 ns (step:158) - (measurement period time:0.386388112 sec time_interval:386388112) - (invoke count:9999978 tsc_interval:1156931610)
> [  500.370790] time_bench: Type:kmem bulk_quick_reuse Per elem: 39 cycles(tsc) 13.189 ns (step:158) - (measurement period time:0.131890805 sec time_interval:131890805) - (invoke count:9999978 tsc_interval:394909920)
> [  500.747241] time_bench: Type:kmem bulk_fallback Per elem: 112 cycles(tsc) 37.645 ns (step:250) - (measurement period time:0.376455749 sec time_interval:376455749) - (invoke count:10000000 tsc_interval:1127192310)
> [  500.897248] time_bench: Type:kmem bulk_quick_reuse Per elem: 44 cycles(tsc) 14.999 ns (step:250) - (measurement period time:0.149997635 sec time_interval:149997635) - (invoke count:10000000 tsc_interval:449125920)
> 
> Orig:
> [   81.987064] time_bench: Type:for_loop Per elem: 2 cycles(tsc) 0.813 ns (step:0) - (measurement period time:0.081397445 sec time_interval:81397445) - (invoke count:100000000 tsc_interval:243727920)
> [   82.595831] time_bench: Type:kmem fastpath reuse Per elem: 178 cycles(tsc) 59.675 ns (step:0) - (measurement period time:0.596752095 sec time_interval:596752095) - (invoke count:10000000 tsc_interval:1786857030)
> [   83.031850] time_bench: Type:kmem bulk_fallback Per elem: 127 cycles(tsc) 42.541 ns (step:1) - (measurement period time:0.425415790 sec time_interval:425415790) - (invoke count:10000000 tsc_interval:1273823670)
> [   83.340838] time_bench: Type:kmem bulk_quick_reuse Per elem: 87 cycles(tsc) 29.200 ns (step:1) - (measurement period time:0.292006301 sec time_interval:292006301) - (invoke count:10000000 tsc_interval:874355190)
> [   83.630781] time_bench: Type:kmem bulk_fallback Per elem: 83 cycles(tsc) 27.923 ns (step:2) - (measurement period time:0.279231691 sec time_interval:279231691) - (invoke count:10000000 tsc_interval:836104170)
> [   83.821746] time_bench: Type:kmem bulk_quick_reuse Per elem: 52 cycles(tsc) 17.611 ns (step:2) - (measurement period time:0.176116770 sec time_interval:176116770) - (invoke count:10000000 tsc_interval:527346570)
> [   84.105841] time_bench: Type:kmem bulk_fallback Per elem: 81 cycles(tsc) 27.184 ns (step:3) - (measurement period time:0.271845630 sec time_interval:271845630) - (invoke count:9999999 tsc_interval:813988260)
> [   84.257733] time_bench: Type:kmem bulk_quick_reuse Per elem: 42 cycles(tsc) 14.120 ns (step:3) - (measurement period time:0.141208965 sec time_interval:141208965) - (invoke count:9999999 tsc_interval:422821890)
> [   84.578730] time_bench: Type:kmem bulk_fallback Per elem: 92 cycles(tsc) 30.798 ns (step:4) - (measurement period time:0.307982589 sec time_interval:307982589) - (invoke count:10000000 tsc_interval:922193070)
> [   84.894740] time_bench: Type:kmem bulk_quick_reuse Per elem: 91 cycles(tsc) 30.523 ns (step:4) - (measurement period time:0.305231656 sec time_interval:305231656) - (invoke count:10000000 tsc_interval:913955310)
> [   85.596699] time_bench: Type:kmem bulk_fallback Per elem: 206 cycles(tsc) 68.977 ns (step:8) - (measurement period time:0.689779758 sec time_interval:689779758) - (invoke count:10000000 tsc_interval:2065410030)
> [   85.728679] time_bench: Type:kmem bulk_quick_reuse Per elem: 31 cycles(tsc) 10.641 ns (step:8) - (measurement period time:0.106415387 sec time_interval:106415387) - (invoke count:10000000 tsc_interval:318639630)
> [   86.016723] time_bench: Type:kmem bulk_fallback Per elem: 81 cycles(tsc) 27.302 ns (step:16) - (measurement period time:0.273021863 sec time_interval:273021863) - (invoke count:10000000 tsc_interval:817509990)
> [   86.137711] time_bench: Type:kmem bulk_quick_reuse Per elem: 29 cycles(tsc) 10.005 ns (step:16) - (measurement period time:0.100053210 sec time_interval:100053210) - (invoke count:10000000 tsc_interval:299589180)
> [   86.420698] time_bench: Type:kmem bulk_fallback Per elem: 79 cycles(tsc) 26.598 ns (step:30) - (measurement period time:0.265984644 sec time_interval:265984644) - (invoke count:9999990 tsc_interval:796437960)
> [   86.534652] time_bench: Type:kmem bulk_quick_reuse Per elem: 29 cycles(tsc) 9.742 ns (step:30) - (measurement period time:0.097425391 sec time_interval:97425391) - (invoke count:9999990 tsc_interval:291720810)
> [   86.812682] time_bench: Type:kmem bulk_fallback Per elem: 79 cycles(tsc) 26.522 ns (step:32) - (measurement period time:0.265225864 sec time_interval:265225864) - (invoke count:10000000 tsc_interval:794166360)
> [   86.923650] time_bench: Type:kmem bulk_quick_reuse Per elem: 29 cycles(tsc) 9.729 ns (step:32) - (measurement period time:0.097294552 sec time_interval:97294552) - (invoke count:10000000 tsc_interval:291328800)
> [   87.255647] time_bench: Type:kmem bulk_fallback Per elem: 95 cycles(tsc) 32.050 ns (step:34) - (measurement period time:0.320499429 sec time_interval:320499429) - (invoke count:9999978 tsc_interval:959672160)
> [   87.383687] time_bench: Type:kmem bulk_quick_reuse Per elem: 34 cycles(tsc) 11.492 ns (step:34) - (measurement period time:0.114921393 sec time_interval:114921393) - (invoke count:9999978 tsc_interval:344109030)
> [   87.724663] time_bench: Type:kmem bulk_fallback Per elem: 96 cycles(tsc) 32.346 ns (step:48) - (measurement period time:0.323463245 sec time_interval:323463245) - (invoke count:9999984 tsc_interval:968546670)
> [   87.847640] time_bench: Type:kmem bulk_quick_reuse Per elem: 31 cycles(tsc) 10.661 ns (step:48) - (measurement period time:0.106610938 sec time_interval:106610938) - (invoke count:9999984 tsc_interval:319225170)
> [   88.167636] time_bench: Type:kmem bulk_fallback Per elem: 91 cycles(tsc) 30.678 ns (step:64) - (measurement period time:0.306781428 sec time_interval:306781428) - (invoke count:10000000 tsc_interval:918596670)
> [   88.287645] time_bench: Type:kmem bulk_quick_reuse Per elem: 31 cycles(tsc) 10.677 ns (step:64) - (measurement period time:0.106773747 sec time_interval:106773747) - (invoke count:10000000 tsc_interval:319712640)
> [   88.634627] time_bench: Type:kmem bulk_fallback Per elem: 100 cycles(tsc) 33.591 ns (step:128) - (measurement period time:0.335914141 sec time_interval:335914141) - (invoke count:10000000 tsc_interval:1005828930)
> [   88.785630] time_bench: Type:kmem bulk_quick_reuse Per elem: 40 cycles(tsc) 13.648 ns (step:128) - (measurement period time:0.136483174 sec time_interval:136483174) - (invoke count:10000000 tsc_interval:408671550)
> [   89.138604] time_bench: Type:kmem bulk_fallback Per elem: 101 cycles(tsc) 33.981 ns (step:158) - (measurement period time:0.339814415 sec time_interval:339814415) - (invoke count:9999978 tsc_interval:1017507030)
> [   89.289633] time_bench: Type:kmem bulk_quick_reuse Per elem: 42 cycles(tsc) 14.110 ns (step:158) - (measurement period time:0.141101621 sec time_interval:141101621) - (invoke count:9999978 tsc_interval:422500530)
> [   89.650638] time_bench: Type:kmem bulk_fallback Per elem: 104 cycles(tsc) 34.887 ns (step:250) - (measurement period time:0.348876887 sec time_interval:348876887) - (invoke count:10000000 tsc_interval:1044643320)
> [   89.813613] time_bench: Type:kmem bulk_quick_reuse Per elem: 44 cycles(tsc) 14.821 ns (step:250) - (measurement period time:0.148213151 sec time_interval:148213151) - (invoke count:10000000 tsc_interval:443794860)
> 
> [  120.495694] time_bench: Type:for_loop Per elem: 2 cycles(tsc) 0.777 ns (step:0) - (measurement period time:0.077764814 sec time_interval:77764814) - (invoke count:100000000 tsc_interval:232850730)
> [  121.018849] time_bench: Type:kmem fastpath reuse Per elem: 153 cycles(tsc) 51.274 ns (step:0) - (measurement period time:0.512740018 sec time_interval:512740018) - (invoke count:10000000 tsc_interval:1535297070)
> [  121.326965] time_bench: Type:kmem bulk_fallback Per elem: 91 cycles(tsc) 30.560 ns (step:1) - (measurement period time:0.305608844 sec time_interval:305608844) - (invoke count:10000000 tsc_interval:915084480)
> [  121.628922] time_bench: Type:kmem bulk_quick_reuse Per elem: 87 cycles(tsc) 29.218 ns (step:1) - (measurement period time:0.292184439 sec time_interval:292184439) - (invoke count:10000000 tsc_interval:874887840)
> [  122.337817] time_bench: Type:kmem bulk_fallback Per elem: 207 cycles(tsc) 69.361 ns (step:2) - (measurement period time:0.693612284 sec time_interval:693612284) - (invoke count:10000000 tsc_interval:2076883890)
> [  122.520912] time_bench: Type:kmem bulk_quick_reuse Per elem: 53 cycles(tsc) 17.741 ns (step:2) - (measurement period time:0.177417675 sec time_interval:177417675) - (invoke count:10000000 tsc_interval:531240870)
> [  122.872912] time_bench: Type:kmem bulk_fallback Per elem: 102 cycles(tsc) 34.212 ns (step:3) - (measurement period time:0.342120142 sec time_interval:342120142) - (invoke count:9999999 tsc_interval:1024409910)
> [  123.019909] time_bench: Type:kmem bulk_quick_reuse Per elem: 42 cycles(tsc) 14.084 ns (step:3) - (measurement period time:0.140842225 sec time_interval:140842225) - (invoke count:9999999 tsc_interval:421723650)
> [  123.837965] time_bench: Type:kmem bulk_fallback Per elem: 241 cycles(tsc) 80.516 ns (step:4) - (measurement period time:0.805161046 sec time_interval:805161046) - (invoke count:10000000 tsc_interval:2410894650)
> [  123.973915] time_bench: Type:kmem bulk_quick_reuse Per elem: 37 cycles(tsc) 12.377 ns (step:4) - (measurement period time:0.123773940 sec time_interval:123773940) - (invoke count:10000000 tsc_interval:370615290)
> [  124.273862] time_bench: Type:kmem bulk_fallback Per elem: 86 cycles(tsc) 28.860 ns (step:8) - (measurement period time:0.288604912 sec time_interval:288604912) - (invoke count:10000000 tsc_interval:864169920)
> [  124.546757] time_bench: Type:kmem bulk_quick_reuse Per elem: 79 cycles(tsc) 26.420 ns (step:8) - (measurement period time:0.264207028 sec time_interval:264207028) - (invoke count:10000000 tsc_interval:791114430)
> [  125.191730] time_bench: Type:kmem bulk_fallback Per elem: 190 cycles(tsc) 63.456 ns (step:16) - (measurement period time:0.634568513 sec time_interval:634568513) - (invoke count:10000000 tsc_interval:1900088820)
> [  125.296839] time_bench: Type:kmem bulk_quick_reuse Per elem: 30 cycles(tsc) 10.043 ns (step:16) - (measurement period time:0.100439926 sec time_interval:100439926) - (invoke count:10000000 tsc_interval:300746670)
> [  125.580743] time_bench: Type:kmem bulk_fallback Per elem: 81 cycles(tsc) 27.347 ns (step:30) - (measurement period time:0.273471271 sec time_interval:273471271) - (invoke count:9999990 tsc_interval:818855040)
> [  125.836734] time_bench: Type:kmem bulk_quick_reuse Per elem: 72 cycles(tsc) 24.372 ns (step:30) - (measurement period time:0.243727806 sec time_interval:243727806) - (invoke count:9999990 tsc_interval:729793590)
> [  126.508883] time_bench: Type:kmem bulk_fallback Per elem: 197 cycles(tsc) 65.900 ns (step:32) - (measurement period time:0.659009779 sec time_interval:659009779) - (invoke count:10000000 tsc_interval:1973273460)
> [  126.612891] time_bench: Type:kmem bulk_quick_reuse Per elem: 29 cycles(tsc) 9.749 ns (step:32) - (measurement period time:0.097491968 sec time_interval:97491968) - (invoke count:10000000 tsc_interval:291919890)
> [  126.968798] time_bench: Type:kmem bulk_fallback Per elem: 103 cycles(tsc) 34.676 ns (step:34) - (measurement period time:0.346762028 sec time_interval:346762028) - (invoke count:9999978 tsc_interval:1038309510)
> [  127.095700] time_bench: Type:kmem bulk_quick_reuse Per elem: 34 cycles(tsc) 11.648 ns (step:34) - (measurement period time:0.116483925 sec time_interval:116483925) - (invoke count:9999978 tsc_interval:348787590)
> [  127.974794] time_bench: Type:kmem bulk_fallback Per elem: 259 cycles(tsc) 86.651 ns (step:48) - (measurement period time:0.866514663 sec time_interval:866514663) - (invoke count:9999984 tsc_interval:2594605770)
> [  128.093772] time_bench: Type:kmem bulk_quick_reuse Per elem: 34 cycles(tsc) 11.426 ns (step:48) - (measurement period time:0.114267827 sec time_interval:114267827) - (invoke count:9999984 tsc_interval:342151620)
> [  128.430665] time_bench: Type:kmem bulk_fallback Per elem: 97 cycles(tsc) 32.514 ns (step:64) - (measurement period time:0.325148101 sec time_interval:325148101) - (invoke count:10000000 tsc_interval:973590990)
> [  128.546857] time_bench: Type:kmem bulk_quick_reuse Per elem: 32 cycles(tsc) 10.991 ns (step:64) - (measurement period time:0.109916673 sec time_interval:109916673) - (invoke count:10000000 tsc_interval:329123280)
> [  129.431645] time_bench: Type:kmem bulk_fallback Per elem: 261 cycles(tsc) 87.191 ns (step:128) - (measurement period time:0.871911323 sec time_interval:871911323) - (invoke count:10000000 tsc_interval:2610764490)
> [  129.583764] time_bench: Type:kmem bulk_quick_reuse Per elem: 43 cycles(tsc) 14.514 ns (step:128) - (measurement period time:0.145148532 sec time_interval:145148532) - (invoke count:10000000 tsc_interval:434617800)
> [  130.443627] time_bench: Type:kmem bulk_fallback Per elem: 254 cycles(tsc) 84.982 ns (step:158) - (measurement period time:0.849826310 sec time_interval:849826310) - (invoke count:9999978 tsc_interval:2544635760)
> [  130.583738] time_bench: Type:kmem bulk_quick_reuse Per elem: 40 cycles(tsc) 13.399 ns (step:158) - (measurement period time:0.133992977 sec time_interval:133992977) - (invoke count:9999978 tsc_interval:401214210)
> [  130.947634] time_bench: Type:kmem bulk_fallback Per elem: 105 cycles(tsc) 35.206 ns (step:250) - (measurement period time:0.352068766 sec time_interval:352068766) - (invoke count:10000000 tsc_interval:1054199400)
> [  131.268601] time_bench: Type:kmem bulk_quick_reuse Per elem: 93 cycles(tsc) 31.142 ns (step:250) - (measurement period time:0.311429067 sec time_interval:311429067) - (invoke count:10000000 tsc_interval:932511270)
> 
> [  135.584335] time_bench: Type:for_loop Per elem: 2 cycles(tsc) 0.772 ns (step:0) - (measurement period time:0.077217374 sec time_interval:77217374) - (invoke count:100000000 tsc_interval:231211500)
> [  136.122480] time_bench: Type:kmem fastpath reuse Per elem: 156 cycles(tsc) 52.212 ns (step:0) - (measurement period time:0.522120964 sec time_interval:522120964) - (invoke count:10000000 tsc_interval:1563386670)
> [  136.762465] time_bench: Type:kmem bulk_fallback Per elem: 186 cycles(tsc) 62.301 ns (step:1) - (measurement period time:0.623010984 sec time_interval:623010984) - (invoke count:10000000 tsc_interval:1865481540)
> [  137.248444] time_bench: Type:kmem bulk_quick_reuse Per elem: 142 cycles(tsc) 47.606 ns (step:1) - (measurement period time:0.476063536 sec time_interval:476063536) - (invoke count:10000000 tsc_interval:1425477150)
> [  137.540440] time_bench: Type:kmem bulk_fallback Per elem: 84 cycles(tsc) 28.282 ns (step:2) - (measurement period time:0.282824344 sec time_interval:282824344) - (invoke count:10000000 tsc_interval:846861210)
> [  137.724456] time_bench: Type:kmem bulk_quick_reuse Per elem: 53 cycles(tsc) 17.830 ns (step:2) - (measurement period time:0.178304559 sec time_interval:178304559) - (invoke count:10000000 tsc_interval:533896980)
> [  138.366442] time_bench: Type:kmem bulk_fallback Per elem: 189 cycles(tsc) 63.289 ns (step:3) - (measurement period time:0.632890657 sec time_interval:632890657) - (invoke count:9999999 tsc_interval:1895064930)
> [  138.682405] time_bench: Type:kmem bulk_quick_reuse Per elem: 91 cycles(tsc) 30.603 ns (step:3) - (measurement period time:0.306034382 sec time_interval:306034382) - (invoke count:9999999 tsc_interval:916357950)
> [  138.997539] time_bench: Type:kmem bulk_fallback Per elem: 90 cycles(tsc) 30.372 ns (step:4) - (measurement period time:0.303723704 sec time_interval:303723704) - (invoke count:10000000 tsc_interval:909440220)
> [  139.131400] time_bench: Type:kmem bulk_quick_reuse Per elem: 37 cycles(tsc) 12.405 ns (step:4) - (measurement period time:0.124058230 sec time_interval:124058230) - (invoke count:10000000 tsc_interval:371467110)
> [  139.430407] time_bench: Type:kmem bulk_fallback Per elem: 86 cycles(tsc) 28.867 ns (step:8) - (measurement period time:0.288673242 sec time_interval:288673242) - (invoke count:10000000 tsc_interval:864374550)
> [  139.694401] time_bench: Type:kmem bulk_quick_reuse Per elem: 76 cycles(tsc) 25.593 ns (step:8) - (measurement period time:0.255935939 sec time_interval:255935939) - (invoke count:10000000 tsc_interval:766348440)
> [  140.387369] time_bench: Type:kmem bulk_fallback Per elem: 203 cycles(tsc) 68.061 ns (step:16) - (measurement period time:0.680610963 sec time_interval:680610963) - (invoke count:10000000 tsc_interval:2037954090)
> [  140.495385] time_bench: Type:kmem bulk_quick_reuse Per elem: 30 cycles(tsc) 10.173 ns (step:16) - (measurement period time:0.101737300 sec time_interval:101737300) - (invoke count:10000000 tsc_interval:304631430)
> [  141.101479] time_bench: Type:kmem bulk_fallback Per elem: 177 cycles(tsc) 59.116 ns (step:30) - (measurement period time:0.591165326 sec time_interval:591165326) - (invoke count:9999990 tsc_interval:1770126360)
> [  141.350337] time_bench: Type:kmem bulk_quick_reuse Per elem: 72 cycles(tsc) 24.305 ns (step:30) - (measurement period time:0.243051460 sec time_interval:243051460) - (invoke count:9999990 tsc_interval:727767660)
> [  141.781369] time_bench: Type:kmem bulk_fallback Per elem: 126 cycles(tsc) 42.191 ns (step:32) - (measurement period time:0.421915112 sec time_interval:421915112) - (invoke count:10000000 tsc_interval:1263340320)
> [  142.029348] time_bench: Type:kmem bulk_quick_reuse Per elem: 72 cycles(tsc) 24.208 ns (step:32) - (measurement period time:0.242082250 sec time_interval:242082250) - (invoke count:10000000 tsc_interval:724865610)
> [  142.833301] time_bench: Type:kmem bulk_fallback Per elem: 237 cycles(tsc) 79.313 ns (step:34) - (measurement period time:0.793128746 sec time_interval:793128746) - (invoke count:9999978 tsc_interval:2374865760)
> [  142.957327] time_bench: Type:kmem bulk_quick_reuse Per elem: 35 cycles(tsc) 11.796 ns (step:34) - (measurement period time:0.117960158 sec time_interval:117960158) - (invoke count:9999978 tsc_interval:353207850)
> [  143.714486] time_bench: Type:kmem bulk_fallback Per elem: 223 cycles(tsc) 74.629 ns (step:48) - (measurement period time:0.746296426 sec time_interval:746296426) - (invoke count:9999984 tsc_interval:2234635890)
> [  143.998413] time_bench: Type:kmem bulk_quick_reuse Per elem: 82 cycles(tsc) 27.476 ns (step:48) - (measurement period time:0.274759868 sec time_interval:274759868) - (invoke count:9999984 tsc_interval:822712920)
> [  144.717341] time_bench: Type:kmem bulk_fallback Per elem: 211 cycles(tsc) 70.598 ns (step:64) - (measurement period time:0.705984861 sec time_interval:705984861) - (invoke count:10000000 tsc_interval:2113930770)
> [  144.838259] time_bench: Type:kmem bulk_quick_reuse Per elem: 32 cycles(tsc) 10.788 ns (step:64) - (measurement period time:0.107887319 sec time_interval:107887319) - (invoke count:10000000 tsc_interval:323046420)
> [  145.190386] time_bench: Type:kmem bulk_fallback Per elem: 102 cycles(tsc) 34.174 ns (step:128) - (measurement period time:0.341741874 sec time_interval:341741874) - (invoke count:10000000 tsc_interval:1023278130)
> [  145.514275] time_bench: Type:kmem bulk_quick_reuse Per elem: 93 cycles(tsc) 31.128 ns (step:128) - (measurement period time:0.311288149 sec time_interval:311288149) - (invoke count:10000000 tsc_interval:932088960)
> [  146.367413] time_bench: Type:kmem bulk_fallback Per elem: 251 cycles(tsc) 84.015 ns (step:158) - (measurement period time:0.840153692 sec time_interval:840153692) - (invoke count:9999978 tsc_interval:2515672920)
> [  146.523219] time_bench: Type:kmem bulk_quick_reuse Per elem: 42 cycles(tsc) 14.280 ns (step:158) - (measurement period time:0.142806094 sec time_interval:142806094) - (invoke count:9999978 tsc_interval:427603830)
> [  146.888375] time_bench: Type:kmem bulk_fallback Per elem: 105 cycles(tsc) 35.119 ns (step:250) - (measurement period time:0.351191259 sec time_interval:351191259) - (invoke count:10000000 tsc_interval:1051571610)
> [  147.291226] time_bench: Type:kmem bulk_quick_reuse Per elem: 117 cycles(tsc) 39.200 ns (step:250) - (measurement period time:0.392003176 sec time_interval:392003176) - (invoke count:10000000 tsc_interval:1173774360)
> 
> 
> SLAB:
> 
> Orig:
> [   80.499545] time_bench: Type:for_loop Per elem: 2 cycles(tsc) 0.830 ns (step:0) - (measurement period time:0.083085912 sec time_interval:83085912) - (invoke count:100000000 tsc_interval:248781840)
> [   81.099911] time_bench: Type:kmem fastpath reuse Per elem: 174 cycles(tsc) 58.430 ns (step:0) - (measurement period time:0.584308185 sec time_interval:584308185) - (invoke count:10000000 tsc_interval:1749584790)
> [   81.421881] time_bench: Type:kmem bulk_fallback Per elem: 89 cycles(tsc) 30.019 ns (step:1) - (measurement period time:0.300198661 sec time_interval:300198661) - (invoke count:10000000 tsc_interval:898879710)
> [   81.910960] time_bench: Type:kmem bulk_quick_reuse Per elem: 143 cycles(tsc) 47.889 ns (step:1) - (measurement period time:0.478893310 sec time_interval:478893310) - (invoke count:10000000 tsc_interval:1433941530)
> [   82.583917] time_bench: Type:kmem bulk_fallback Per elem: 197 cycles(tsc) 65.813 ns (step:2) - (measurement period time:0.658134429 sec time_interval:658134429) - (invoke count:10000000 tsc_interval:1970640660)
> [   82.751867] time_bench: Type:kmem bulk_quick_reuse Per elem: 45 cycles(tsc) 15.221 ns (step:2) - (measurement period time:0.152212195 sec time_interval:152212195) - (invoke count:10000000 tsc_interval:455766000)
> [   83.047850] time_bench: Type:kmem bulk_fallback Per elem: 83 cycles(tsc) 27.831 ns (step:3) - (measurement period time:0.278309326 sec time_interval:278309326) - (invoke count:9999999 tsc_interval:833336640)
> [   83.186831] time_bench: Type:kmem bulk_quick_reuse Per elem: 38 cycles(tsc) 12.885 ns (step:3) - (measurement period time:0.128853000 sec time_interval:128853000) - (invoke count:9999999 tsc_interval:385821900)
> [   83.514848] time_bench: Type:kmem bulk_fallback Per elem: 92 cycles(tsc) 30.901 ns (step:4) - (measurement period time:0.309012550 sec time_interval:309012550) - (invoke count:10000000 tsc_interval:925270980)
> [   83.646835] time_bench: Type:kmem bulk_quick_reuse Per elem: 35 cycles(tsc) 11.711 ns (step:4) - (measurement period time:0.117116655 sec time_interval:117116655) - (invoke count:10000000 tsc_interval:350679900)
> [   83.954817] time_bench: Type:kmem bulk_fallback Per elem: 89 cycles(tsc) 29.739 ns (step:8) - (measurement period time:0.297398266 sec time_interval:297398266) - (invoke count:10000000 tsc_interval:890494290)
> [   84.069826] time_bench: Type:kmem bulk_quick_reuse Per elem: 29 cycles(tsc) 9.943 ns (step:8) - (measurement period time:0.099437599 sec time_interval:99437599) - (invoke count:10000000 tsc_interval:297743760)
> [   84.361844] time_bench: Type:kmem bulk_fallback Per elem: 84 cycles(tsc) 28.263 ns (step:16) - (measurement period time:0.282630878 sec time_interval:282630878) - (invoke count:10000000 tsc_interval:846277020)
> [   84.471816] time_bench: Type:kmem bulk_quick_reuse Per elem: 28 cycles(tsc) 9.643 ns (step:16) - (measurement period time:0.096439729 sec time_interval:96439729) - (invoke count:10000000 tsc_interval:288767550)
> [   84.977793] time_bench: Type:kmem bulk_fallback Per elem: 145 cycles(tsc) 48.452 ns (step:30) - (measurement period time:0.484520609 sec time_interval:484520609) - (invoke count:9999990 tsc_interval:1450791510)
> [   85.222771] time_bench: Type:kmem bulk_quick_reuse Per elem: 68 cycles(tsc) 22.726 ns (step:30) - (measurement period time:0.227266268 sec time_interval:227266268) - (invoke count:9999990 tsc_interval:680498580)
> [   85.814766] time_bench: Type:kmem bulk_fallback Per elem: 173 cycles(tsc) 57.907 ns (step:32) - (measurement period time:0.579072933 sec time_interval:579072933) - (invoke count:10000000 tsc_interval:1733908170)
> [   85.914739] time_bench: Type:kmem bulk_quick_reuse Per elem: 28 cycles(tsc) 9.385 ns (step:32) - (measurement period time:0.093857661 sec time_interval:93857661) - (invoke count:10000000 tsc_interval:281035770)
> [   86.207764] time_bench: Type:kmem bulk_fallback Per elem: 82 cycles(tsc) 27.489 ns (step:34) - (measurement period time:0.274891966 sec time_interval:274891966) - (invoke count:9999978 tsc_interval:823104480)
> [   86.452755] time_bench: Type:kmem bulk_quick_reuse Per elem: 68 cycles(tsc) 23.040 ns (step:34) - (measurement period time:0.230401610 sec time_interval:230401610) - (invoke count:9999978 tsc_interval:689886630)
> [   86.736743] time_bench: Type:kmem bulk_fallback Per elem: 81 cycles(tsc) 27.326 ns (step:48) - (measurement period time:0.273267062 sec time_interval:273267062) - (invoke count:9999984 tsc_interval:818238330)
> [   86.839857] time_bench: Type:kmem bulk_quick_reuse Per elem: 28 cycles(tsc) 9.506 ns (step:48) - (measurement period time:0.095059470 sec time_interval:95059470) - (invoke count:9999984 tsc_interval:284634690)
> [   87.432947] time_bench: Type:kmem bulk_fallback Per elem: 172 cycles(tsc) 57.565 ns (step:64) - (measurement period time:0.575650143 sec time_interval:575650143) - (invoke count:10000000 tsc_interval:1723659720)
> [   87.536682] time_bench: Type:kmem bulk_quick_reuse Per elem: 27 cycles(tsc) 9.267 ns (step:64) - (measurement period time:0.092674016 sec time_interval:92674016) - (invoke count:10000000 tsc_interval:277491600)
> [   87.829693] time_bench: Type:kmem bulk_fallback Per elem: 84 cycles(tsc) 28.082 ns (step:128) - (measurement period time:0.280825239 sec time_interval:280825239) - (invoke count:10000000 tsc_interval:840869820)
> [   87.942860] time_bench: Type:kmem bulk_quick_reuse Per elem: 31 cycles(tsc) 10.387 ns (step:128) - (measurement period time:0.103871104 sec time_interval:103871104) - (invoke count:10000000 tsc_interval:311019150)
> [   88.242686] time_bench: Type:kmem bulk_fallback Per elem: 84 cycles(tsc) 28.101 ns (step:158) - (measurement period time:0.281012946 sec time_interval:281012946) - (invoke count:9999978 tsc_interval:841431990)
> [   88.354683] time_bench: Type:kmem bulk_quick_reuse Per elem: 29 cycles(tsc) 9.852 ns (step:158) - (measurement period time:0.098524040 sec time_interval:98524040) - (invoke count:9999978 tsc_interval:295008030)
> [   88.655671] time_bench: Type:kmem bulk_fallback Per elem: 86 cycles(tsc) 28.946 ns (step:250) - (measurement period time:0.289463793 sec time_interval:289463793) - (invoke count:10000000 tsc_interval:866736720)
> [   88.776655] time_bench: Type:kmem bulk_quick_reuse Per elem: 32 cycles(tsc) 10.695 ns (step:250) - (measurement period time:0.106953355 sec time_interval:106953355) - (invoke count:10000000 tsc_interval:320247930)
> 
> [  100.068788] time_bench: Type:for_loop Per elem: 4 cycles(tsc) 1.567 ns (step:0) - (measurement period time:0.156710185 sec time_interval:156710185) - (invoke count:100000000 tsc_interval:469233480)
> [  100.654304] time_bench: Type:kmem fastpath reuse Per elem: 170 cycles(tsc) 56.967 ns (step:0) - (measurement period time:0.569671924 sec time_interval:569671924) - (invoke count:10000000 tsc_interval:1705759620)
> [  101.373300] time_bench: Type:kmem bulk_fallback Per elem: 212 cycles(tsc) 70.812 ns (step:1) - (measurement period time:0.708129741 sec time_interval:708129741) - (invoke count:10000000 tsc_interval:2120342250)
> [  101.840283] time_bench: Type:kmem bulk_quick_reuse Per elem: 136 cycles(tsc) 45.527 ns (step:1) - (measurement period time:0.455275848 sec time_interval:455275848) - (invoke count:10000000 tsc_interval:1363225020)
> [  102.139276] time_bench: Type:kmem bulk_fallback Per elem: 86 cycles(tsc) 29.044 ns (step:2) - (measurement period time:0.290446762 sec time_interval:290446762) - (invoke count:10000000 tsc_interval:869680110)
> [  102.303272] time_bench: Type:kmem bulk_quick_reuse Per elem: 46 cycles(tsc) 15.383 ns (step:2) - (measurement period time:0.153838537 sec time_interval:153838537) - (invoke count:10000000 tsc_interval:460636140)
> [  103.012346] time_bench: Type:kmem bulk_fallback Per elem: 209 cycles(tsc) 69.979 ns (step:3) - (measurement period time:0.699793666 sec time_interval:699793666) - (invoke count:9999999 tsc_interval:2095381860)
> [  103.148352] time_bench: Type:kmem bulk_quick_reuse Per elem: 39 cycles(tsc) 13.208 ns (step:3) - (measurement period time:0.132082868 sec time_interval:132082868) - (invoke count:9999999 tsc_interval:395493210)
> [  103.462233] time_bench: Type:kmem bulk_fallback Per elem: 91 cycles(tsc) 30.467 ns (step:4) - (measurement period time:0.304675759 sec time_interval:304675759) - (invoke count:10000000 tsc_interval:912285930)
> [  103.761428] time_bench: Type:kmem bulk_quick_reuse Per elem: 87 cycles(tsc) 29.059 ns (step:4) - (measurement period time:0.290597158 sec time_interval:290597158) - (invoke count:10000000 tsc_interval:870129780)
> [  104.501334] time_bench: Type:kmem bulk_fallback Per elem: 218 cycles(tsc) 73.076 ns (step:8) - (measurement period time:0.730767822 sec time_interval:730767822) - (invoke count:10000000 tsc_interval:2188127310)
> [  104.732329] time_bench: Type:kmem bulk_quick_reuse Per elem: 66 cycles(tsc) 22.280 ns (step:8) - (measurement period time:0.222806934 sec time_interval:222806934) - (invoke count:10000000 tsc_interval:667146780)
> [  105.346195] time_bench: Type:kmem bulk_fallback Per elem: 180 cycles(tsc) 60.308 ns (step:16) - (measurement period time:0.603085855 sec time_interval:603085855) - (invoke count:10000000 tsc_interval:1805810910)
> [  105.565213] time_bench: Type:kmem bulk_quick_reuse Per elem: 62 cycles(tsc) 20.731 ns (step:16) - (measurement period time:0.207317878 sec time_interval:207317878) - (invoke count:10000000 tsc_interval:620768190)
> [  106.154163] time_bench: Type:kmem bulk_fallback Per elem: 173 cycles(tsc) 57.884 ns (step:30) - (measurement period time:0.578841035 sec time_interval:578841035) - (invoke count:9999990 tsc_interval:1733213910)
> [  106.450218] time_bench: Type:kmem bulk_quick_reuse Per elem: 85 cycles(tsc) 28.455 ns (step:30) - (measurement period time:0.284558769 sec time_interval:284558769) - (invoke count:9999990 tsc_interval:852048780)
> [  107.137140] time_bench: Type:kmem bulk_fallback Per elem: 199 cycles(tsc) 66.729 ns (step:32) - (measurement period time:0.667298185 sec time_interval:667298185) - (invoke count:10000000 tsc_interval:1998081120)
> [  107.244232] time_bench: Type:kmem bulk_quick_reuse Per elem: 28 cycles(tsc) 9.655 ns (step:32) - (measurement period time:0.096558958 sec time_interval:96558958) - (invoke count:10000000 tsc_interval:289124430)
> [  107.528225] time_bench: Type:kmem bulk_fallback Per elem: 82 cycles(tsc) 27.584 ns (step:34) - (measurement period time:0.275841028 sec time_interval:275841028) - (invoke count:9999978 tsc_interval:825940800)
> [  107.628207] time_bench: Type:kmem bulk_quick_reuse Per elem: 27 cycles(tsc) 9.182 ns (step:34) - (measurement period time:0.091822659 sec time_interval:91822659) - (invoke count:9999978 tsc_interval:274942830)
> [  107.913114] time_bench: Type:kmem bulk_fallback Per elem: 82 cycles(tsc) 27.639 ns (step:48) - (measurement period time:0.276397658 sec time_interval:276397658) - (invoke count:9999984 tsc_interval:827612400)
> [  108.013118] time_bench: Type:kmem bulk_quick_reuse Per elem: 27 cycles(tsc) 9.281 ns (step:48) - (measurement period time:0.092811773 sec time_interval:92811773) - (invoke count:9999984 tsc_interval:277904550)
> [  108.293222] time_bench: Type:kmem bulk_fallback Per elem: 82 cycles(tsc) 27.413 ns (step:64) - (measurement period time:0.274134107 sec time_interval:274134107) - (invoke count:10000000 tsc_interval:820835190)
> [  108.394122] time_bench: Type:kmem bulk_quick_reuse Per elem: 27 cycles(tsc) 9.252 ns (step:64) - (measurement period time:0.092524305 sec time_interval:92524305) - (invoke count:10000000 tsc_interval:277043580)
> [  109.015115] time_bench: Type:kmem bulk_fallback Per elem: 183 cycles(tsc) 61.171 ns (step:128) - (measurement period time:0.611713784 sec time_interval:611713784) - (invoke count:10000000 tsc_interval:1831645590)
> [  109.282175] time_bench: Type:kmem bulk_quick_reuse Per elem: 76 cycles(tsc) 25.538 ns (step:128) - (measurement period time:0.255382498 sec time_interval:255382498) - (invoke count:10000000 tsc_interval:764687130)
> [  109.898178] time_bench: Type:kmem bulk_fallback Per elem: 181 cycles(tsc) 60.732 ns (step:158) - (measurement period time:0.607324486 sec time_interval:607324486) - (invoke count:9999978 tsc_interval:1818501990)
> [  110.111052] time_bench: Type:kmem bulk_quick_reuse Per elem: 60 cycles(tsc) 20.241 ns (step:158) - (measurement period time:0.202414120 sec time_interval:202414120) - (invoke count:9999978 tsc_interval:606085230)
> [  110.715034] time_bench: Type:kmem bulk_fallback Per elem: 178 cycles(tsc) 59.483 ns (step:250) - (measurement period time:0.594833299 sec time_interval:594833299) - (invoke count:10000000 tsc_interval:1781100600)
> [  110.974129] time_bench: Type:kmem bulk_quick_reuse Per elem: 75 cycles(tsc) 25.167 ns (step:250) - (measurement period time:0.251679547 sec time_interval:251679547) - (invoke count:10000000 tsc_interval:753599310)
> 
> [  111.856730] time_bench: Type:for_loop Per elem: 4 cycles(tsc) 1.349 ns (step:0) - (measurement period time:0.134993630 sec time_interval:134993630) - (invoke count:100000000 tsc_interval:404208090)
> [  112.407098] time_bench: Type:kmem fastpath reuse Per elem: 159 cycles(tsc) 53.400 ns (step:0) - (measurement period time:0.534001917 sec time_interval:534001917) - (invoke count:10000000 tsc_interval:1598953680)
> [  113.150981] time_bench: Type:kmem bulk_fallback Per elem: 216 cycles(tsc) 72.396 ns (step:1) - (measurement period time:0.723960939 sec time_interval:723960939) - (invoke count:10000000 tsc_interval:2167744650)
> [  113.381971] time_bench: Type:kmem bulk_quick_reuse Per elem: 67 cycles(tsc) 22.501 ns (step:1) - (measurement period time:0.225017504 sec time_interval:225017504) - (invoke count:10000000 tsc_interval:673765620)
> [  113.681963] time_bench: Type:kmem bulk_fallback Per elem: 86 cycles(tsc) 28.967 ns (step:2) - (measurement period time:0.289671345 sec time_interval:289671345) - (invoke count:10000000 tsc_interval:867358230)
> [  113.843955] time_bench: Type:kmem bulk_quick_reuse Per elem: 46 cycles(tsc) 15.643 ns (step:2) - (measurement period time:0.156437917 sec time_interval:156437917) - (invoke count:10000000 tsc_interval:468418740)
> [  114.140953] time_bench: Type:kmem bulk_fallback Per elem: 85 cycles(tsc) 28.414 ns (step:3) - (measurement period time:0.284148848 sec time_interval:284148848) - (invoke count:9999999 tsc_interval:850821930)
> [  114.279933] time_bench: Type:kmem bulk_quick_reuse Per elem: 39 cycles(tsc) 13.207 ns (step:3) - (measurement period time:0.132073229 sec time_interval:132073229) - (invoke count:9999999 tsc_interval:395463870)
> [  114.609120] time_bench: Type:kmem bulk_fallback Per elem: 93 cycles(tsc) 31.197 ns (step:4) - (measurement period time:0.311972955 sec time_interval:311972955) - (invoke count:10000000 tsc_interval:934136040)
> [  114.909950] time_bench: Type:kmem bulk_quick_reuse Per elem: 87 cycles(tsc) 29.326 ns (step:4) - (measurement period time:0.293267093 sec time_interval:293267093) - (invoke count:10000000 tsc_interval:878124330)
> [  115.622058] time_bench: Type:kmem bulk_fallback Per elem: 209 cycles(tsc) 70.083 ns (step:8) - (measurement period time:0.700833456 sec time_interval:700833456) - (invoke count:10000000 tsc_interval:2098495740)
> [  115.729918] time_bench: Type:kmem bulk_quick_reuse Per elem: 30 cycles(tsc) 10.072 ns (step:8) - (measurement period time:0.100729060 sec time_interval:100729060) - (invoke count:10000000 tsc_interval:301610850)
> [  116.445890] time_bench: Type:kmem bulk_fallback Per elem: 211 cycles(tsc) 70.512 ns (step:16) - (measurement period time:0.705126903 sec time_interval:705126903) - (invoke count:10000000 tsc_interval:2111350800)
> [  116.597986] time_bench: Type:kmem bulk_quick_reuse Per elem: 43 cycles(tsc) 14.451 ns (step:16) - (measurement period time:0.144517256 sec time_interval:144517256) - (invoke count:10000000 tsc_interval:432725340)
> [  117.293842] time_bench: Type:kmem bulk_fallback Per elem: 205 cycles(tsc) 68.660 ns (step:30) - (measurement period time:0.686602607 sec time_interval:686602607) - (invoke count:9999990 tsc_interval:2055883860)
> [  117.513834] time_bench: Type:kmem bulk_quick_reuse Per elem: 65 cycles(tsc) 21.724 ns (step:30) - (measurement period time:0.217241306 sec time_interval:217241306) - (invoke count:9999990 tsc_interval:650481120)
> [  118.157816] time_bench: Type:kmem bulk_fallback Per elem: 189 cycles(tsc) 63.344 ns (step:32) - (measurement period time:0.633443044 sec time_interval:633443044) - (invoke count:10000000 tsc_interval:1896708780)
> [  118.380992] time_bench: Type:kmem bulk_quick_reuse Per elem: 64 cycles(tsc) 21.381 ns (step:32) - (measurement period time:0.213815392 sec time_interval:213815392) - (invoke count:10000000 tsc_interval:640223670)
> [  118.981808] time_bench: Type:kmem bulk_fallback Per elem: 176 cycles(tsc) 58.885 ns (step:34) - (measurement period time:0.588855917 sec time_interval:588855917) - (invoke count:9999978 tsc_interval:1763201640)
> [  119.078787] time_bench: Type:kmem bulk_quick_reuse Per elem: 27 cycles(tsc) 9.191 ns (step:34) - (measurement period time:0.091919103 sec time_interval:91919103) - (invoke count:9999978 tsc_interval:275231340)
> [  119.368789] time_bench: Type:kmem bulk_fallback Per elem: 82 cycles(tsc) 27.533 ns (step:48) - (measurement period time:0.275334132 sec time_interval:275334132) - (invoke count:9999984 tsc_interval:824428110)
> [  119.471780] time_bench: Type:kmem bulk_quick_reuse Per elem: 28 cycles(tsc) 9.519 ns (step:48) - (measurement period time:0.095195091 sec time_interval:95195091) - (invoke count:9999984 tsc_interval:285040080)
> [  119.775775] time_bench: Type:kmem bulk_fallback Per elem: 87 cycles(tsc) 29.149 ns (step:64) - (measurement period time:0.291498274 sec time_interval:291498274) - (invoke count:10000000 tsc_interval:872828640)
> [  119.896771] time_bench: Type:kmem bulk_quick_reuse Per elem: 33 cycles(tsc) 11.330 ns (step:64) - (measurement period time:0.113304207 sec time_interval:113304207) - (invoke count:10000000 tsc_interval:339264000)
> [  120.199773] time_bench: Type:kmem bulk_fallback Per elem: 87 cycles(tsc) 29.289 ns (step:128) - (measurement period time:0.292891157 sec time_interval:292891157) - (invoke count:10000000 tsc_interval:876999360)
> [  120.320757] time_bench: Type:kmem bulk_quick_reuse Per elem: 34 cycles(tsc) 11.476 ns (step:128) - (measurement period time:0.114763286 sec time_interval:114763286) - (invoke count:10000000 tsc_interval:343632900)
> [  120.976762] time_bench: Type:kmem bulk_fallback Per elem: 192 cycles(tsc) 64.320 ns (step:158) - (measurement period time:0.643207519 sec time_interval:643207519) - (invoke count:9999978 tsc_interval:1925946840)
> [  121.231790] time_bench: Type:kmem bulk_quick_reuse Per elem: 73 cycles(tsc) 24.705 ns (step:158) - (measurement period time:0.247055281 sec time_interval:247055281) - (invoke count:9999978 tsc_interval:739752480)
> [  121.875817] time_bench: Type:kmem bulk_fallback Per elem: 189 cycles(tsc) 63.224 ns (step:250) - (measurement period time:0.632244442 sec time_interval:632244442) - (invoke count:10000000 tsc_interval:1893119520)
> [  122.148737] time_bench: Type:kmem bulk_quick_reuse Per elem: 79 cycles(tsc) 26.410 ns (step:250) - (measurement period time:0.264101742 sec time_interval:264101742) - (invoke count:10000000 tsc_interval:790794030)
> 
> Patched:
> 
> [  654.054203] time_bench: Type:for_loop Per elem: 2 cycles(tsc) 0.776 ns (step:0) - (measurement period time:0.077664118 sec time_interval:77664118) - (invoke count:100000000 tsc_interval:232545750)
> [  654.592857] time_bench: Type:kmem fastpath reuse Per elem: 161 cycles(tsc) 53.860 ns (step:0) - (measurement period time:0.538607021 sec time_interval:538607021) - (invoke count:10000000 tsc_interval:1612734660)
> [  655.248550] time_bench: Type:kmem bulk_fallback Per elem: 196 cycles(tsc) 65.568 ns (step:1) - (measurement period time:0.655680061 sec time_interval:655680061) - (invoke count:10000000 tsc_interval:1963282620)
> [  655.475563] time_bench: Type:kmem bulk_quick_reuse Per elem: 67 cycles(tsc) 22.697 ns (step:1) - (measurement period time:0.226975586 sec time_interval:226975586) - (invoke count:10000000 tsc_interval:679625070)
> [  655.757615] time_bench: Type:kmem bulk_fallback Per elem: 84 cycles(tsc) 28.204 ns (step:2) - (measurement period time:0.282047104 sec time_interval:282047104) - (invoke count:10000000 tsc_interval:844524090)
> [  655.943657] time_bench: Type:kmem bulk_quick_reuse Per elem: 55 cycles(tsc) 18.599 ns (step:2) - (measurement period time:0.185992389 sec time_interval:185992389) - (invoke count:10000000 tsc_interval:556910100)
> [  656.221528] time_bench: Type:kmem bulk_fallback Per elem: 83 cycles(tsc) 27.783 ns (step:3) - (measurement period time:0.277833288 sec time_interval:277833288) - (invoke count:9999999 tsc_interval:831906840)
> [  656.535062] time_bench: Type:kmem bulk_quick_reuse Per elem: 93 cycles(tsc) 31.351 ns (step:3) - (measurement period time:0.313512217 sec time_interval:313512217) - (invoke count:9999999 tsc_interval:938739120)
> [  656.843267] time_bench: Type:kmem bulk_fallback Per elem: 92 cycles(tsc) 30.818 ns (step:4) - (measurement period time:0.308185034 sec time_interval:308185034) - (invoke count:10000000 tsc_interval:922788240)
> [  656.961808] time_bench: Type:kmem bulk_quick_reuse Per elem: 35 cycles(tsc) 11.850 ns (step:4) - (measurement period time:0.118503561 sec time_interval:118503561) - (invoke count:10000000 tsc_interval:354830820)
> [  657.691366] time_bench: Type:kmem bulk_fallback Per elem: 218 cycles(tsc) 72.954 ns (step:8) - (measurement period time:0.729541418 sec time_interval:729541418) - (invoke count:10000000 tsc_interval:2184443100)
> [  657.792001] time_bench: Type:kmem bulk_quick_reuse Per elem: 30 cycles(tsc) 10.060 ns (step:8) - (measurement period time:0.100604744 sec time_interval:100604744) - (invoke count:10000000 tsc_interval:301236990)
> [  658.070712] time_bench: Type:kmem bulk_fallback Per elem: 83 cycles(tsc) 27.868 ns (step:16) - (measurement period time:0.278687720 sec time_interval:278687720) - (invoke count:10000000 tsc_interval:834465960)
> [  658.169621] time_bench: Type:kmem bulk_quick_reuse Per elem: 29 cycles(tsc) 9.887 ns (step:16) - (measurement period time:0.098871033 sec time_interval:98871033) - (invoke count:10000000 tsc_interval:296045940)
> [  658.846891] time_bench: Type:kmem bulk_fallback Per elem: 202 cycles(tsc) 67.726 ns (step:30) - (measurement period time:0.677260248 sec time_interval:677260248) - (invoke count:9999990 tsc_interval:2027899590)
> [  658.940547] time_bench: Type:kmem bulk_quick_reuse Per elem: 28 cycles(tsc) 9.354 ns (step:30) - (measurement period time:0.093547668 sec time_interval:93547668) - (invoke count:9999990 tsc_interval:280105560)
> [  659.214131] time_bench: Type:kmem bulk_fallback Per elem: 81 cycles(tsc) 27.356 ns (step:32) - (measurement period time:0.273564878 sec time_interval:273564878) - (invoke count:10000000 tsc_interval:819126750)
> [  659.307010] time_bench: Type:kmem bulk_quick_reuse Per elem: 27 cycles(tsc) 9.286 ns (step:32) - (measurement period time:0.092862249 sec time_interval:92862249) - (invoke count:10000000 tsc_interval:278053470)
> [  659.577675] time_bench: Type:kmem bulk_fallback Per elem: 81 cycles(tsc) 27.065 ns (step:34) - (measurement period time:0.270657877 sec time_interval:270657877) - (invoke count:9999978 tsc_interval:810422340)
> [  659.670155] time_bench: Type:kmem bulk_quick_reuse Per elem: 27 cycles(tsc) 9.246 ns (step:34) - (measurement period time:0.092468447 sec time_interval:92468447) - (invoke count:9999978 tsc_interval:276874410)
> [  659.941498] time_bench: Type:kmem bulk_fallback Per elem: 81 cycles(tsc) 27.129 ns (step:48) - (measurement period time:0.271292799 sec time_interval:271292799) - (invoke count:9999984 tsc_interval:812323620)
> [  660.034358] time_bench: Type:kmem bulk_quick_reuse Per elem: 27 cycles(tsc) 9.284 ns (step:48) - (measurement period time:0.092846689 sec time_interval:92846689) - (invoke count:9999984 tsc_interval:278007390)
> [  660.305652] time_bench: Type:kmem bulk_fallback Per elem: 81 cycles(tsc) 27.125 ns (step:64) - (measurement period time:0.271257793 sec time_interval:271257793) - (invoke count:10000000 tsc_interval:812218680)
> [  660.535235] time_bench: Type:kmem bulk_quick_reuse Per elem: 68 cycles(tsc) 22.955 ns (step:64) - (measurement period time:0.229550122 sec time_interval:229550122) - (invoke count:10000000 tsc_interval:687333360)
> [  660.814888] time_bench: Type:kmem bulk_fallback Per elem: 83 cycles(tsc) 27.964 ns (step:128) - (measurement period time:0.279643666 sec time_interval:279643666) - (invoke count:10000000 tsc_interval:837328200)
> [  660.915969] time_bench: Type:kmem bulk_quick_reuse Per elem: 30 cycles(tsc) 10.104 ns (step:128) - (measurement period time:0.101047589 sec time_interval:101047589) - (invoke count:10000000 tsc_interval:302562990)
> [  661.275325] time_bench: Type:kmem bulk_fallback Per elem: 107 cycles(tsc) 35.933 ns (step:158) - (measurement period time:0.359338210 sec time_interval:359338210) - (invoke count:9999978 tsc_interval:1075954290)
> [  661.375091] time_bench: Type:kmem bulk_quick_reuse Per elem: 29 cycles(tsc) 9.975 ns (step:158) - (measurement period time:0.099750172 sec time_interval:99750172) - (invoke count:9999978 tsc_interval:298678200)
> [  661.655844] time_bench: Type:kmem bulk_fallback Per elem: 84 cycles(tsc) 28.074 ns (step:250) - (measurement period time:0.280746521 sec time_interval:280746521) - (invoke count:10000000 tsc_interval:840630900)
> [  661.762658] time_bench: Type:kmem bulk_quick_reuse Per elem: 31 cycles(tsc) 10.680 ns (step:250) - (measurement period time:0.106802018 sec time_interval:106802018) - (invoke count:10000000 tsc_interval:319793460)
> 
> [  663.188701] time_bench: Type:for_loop Per elem: 2 cycles(tsc) 0.772 ns (step:0) - (measurement period time:0.077219119 sec time_interval:77219119) - (invoke count:100000000 tsc_interval:231214350)
> [  663.723737] time_bench: Type:kmem fastpath reuse Per elem: 160 cycles(tsc) 53.501 ns (step:0) - (measurement period time:0.535016285 sec time_interval:535016285) - (invoke count:10000000 tsc_interval:1601983200)
> [  664.022069] time_bench: Type:kmem bulk_fallback Per elem: 89 cycles(tsc) 29.828 ns (step:1) - (measurement period time:0.298280101 sec time_interval:298280101) - (invoke count:10000000 tsc_interval:893130450)
> [  664.248849] time_bench: Type:kmem bulk_quick_reuse Per elem: 67 cycles(tsc) 22.677 ns (step:1) - (measurement period time:0.226775284 sec time_interval:226775284) - (invoke count:10000000 tsc_interval:679026090)
> [  664.530649] time_bench: Type:kmem bulk_fallback Per elem: 84 cycles(tsc) 28.179 ns (step:2) - (measurement period time:0.281793671 sec time_interval:281793671) - (invoke count:10000000 tsc_interval:843766020)
> [  664.686627] time_bench: Type:kmem bulk_quick_reuse Per elem: 46 cycles(tsc) 15.593 ns (step:2) - (measurement period time:0.155939154 sec time_interval:155939154) - (invoke count:10000000 tsc_interval:466923720)
> [  665.370321] time_bench: Type:kmem bulk_fallback Per elem: 204 cycles(tsc) 68.367 ns (step:3) - (measurement period time:0.683678844 sec time_interval:683678844) - (invoke count:9999999 tsc_interval:2047118220)
> [  665.685507] time_bench: Type:kmem bulk_quick_reuse Per elem: 94 cycles(tsc) 31.513 ns (step:3) - (measurement period time:0.315139143 sec time_interval:315139143) - (invoke count:9999999 tsc_interval:943611060)
> [  666.448847] time_bench: Type:kmem bulk_fallback Per elem: 228 cycles(tsc) 76.331 ns (step:4) - (measurement period time:0.763310680 sec time_interval:763310680) - (invoke count:10000000 tsc_interval:2285557860)
> [  666.745314] time_bench: Type:kmem bulk_quick_reuse Per elem: 88 cycles(tsc) 29.643 ns (step:4) - (measurement period time:0.296436791 sec time_interval:296436791) - (invoke count:10000000 tsc_interval:887610960)
> [  667.041829] time_bench: Type:kmem bulk_fallback Per elem: 88 cycles(tsc) 29.650 ns (step:8) - (measurement period time:0.296505592 sec time_interval:296505592) - (invoke count:10000000 tsc_interval:887817120)
> [  667.142484] time_bench: Type:kmem bulk_quick_reuse Per elem: 30 cycles(tsc) 10.064 ns (step:8) - (measurement period time:0.100642315 sec time_interval:100642315) - (invoke count:10000000 tsc_interval:301350000)
> [  667.420593] time_bench: Type:kmem bulk_fallback Per elem: 83 cycles(tsc) 27.810 ns (step:16) - (measurement period time:0.278104977 sec time_interval:278104977) - (invoke count:10000000 tsc_interval:832721010)
> [  667.519271] time_bench: Type:kmem bulk_quick_reuse Per elem: 29 cycles(tsc) 9.866 ns (step:16) - (measurement period time:0.098662815 sec time_interval:98662815) - (invoke count:10000000 tsc_interval:295422450)
> [  667.792475] time_bench: Type:kmem bulk_fallback Per elem: 81 cycles(tsc) 27.315 ns (step:30) - (measurement period time:0.273152701 sec time_interval:273152701) - (invoke count:9999990 tsc_interval:817892820)
> [  668.023804] time_bench: Type:kmem bulk_quick_reuse Per elem: 69 cycles(tsc) 23.130 ns (step:30) - (measurement period time:0.231303811 sec time_interval:231303811) - (invoke count:9999990 tsc_interval:692584950)
> [  668.696907] time_bench: Type:kmem bulk_fallback Per elem: 201 cycles(tsc) 67.306 ns (step:32) - (measurement period time:0.673067682 sec time_interval:673067682) - (invoke count:10000000 tsc_interval:2015345790)
> [  668.889019] time_bench: Type:kmem bulk_quick_reuse Per elem: 57 cycles(tsc) 19.208 ns (step:32) - (measurement period time:0.192088279 sec time_interval:192088279) - (invoke count:10000000 tsc_interval:575162820)
> [  669.342870] time_bench: Type:kmem bulk_fallback Per elem: 135 cycles(tsc) 45.383 ns (step:34) - (measurement period time:0.453831353 sec time_interval:453831353) - (invoke count:9999978 tsc_interval:1358892420)
> [  669.436107] time_bench: Type:kmem bulk_quick_reuse Per elem: 27 cycles(tsc) 9.322 ns (step:34) - (measurement period time:0.093220843 sec time_interval:93220843) - (invoke count:9999978 tsc_interval:279126840)
> [  669.707772] time_bench: Type:kmem bulk_fallback Per elem: 81 cycles(tsc) 27.165 ns (step:48) - (measurement period time:0.271654970 sec time_interval:271654970) - (invoke count:9999984 tsc_interval:813407310)
> [  669.800509] time_bench: Type:kmem bulk_quick_reuse Per elem: 27 cycles(tsc) 9.268 ns (step:48) - (measurement period time:0.092683978 sec time_interval:92683978) - (invoke count:9999984 tsc_interval:277520190)
> [  670.068757] time_bench: Type:kmem bulk_fallback Per elem: 80 cycles(tsc) 26.823 ns (step:64) - (measurement period time:0.268231313 sec time_interval:268231313) - (invoke count:10000000 tsc_interval:803156580)
> [  670.297078] time_bench: Type:kmem bulk_quick_reuse Per elem: 68 cycles(tsc) 22.829 ns (step:64) - (measurement period time:0.228295958 sec time_interval:228295958) - (invoke count:10000000 tsc_interval:683578080)
> [  670.573819] time_bench: Type:kmem bulk_fallback Per elem: 82 cycles(tsc) 27.673 ns (step:128) - (measurement period time:0.276731254 sec time_interval:276731254) - (invoke count:10000000 tsc_interval:828607050)
> [  670.676864] time_bench: Type:kmem bulk_quick_reuse Per elem: 30 cycles(tsc) 10.300 ns (step:128) - (measurement period time:0.103002111 sec time_interval:103002111) - (invoke count:10000000 tsc_interval:308415540)
> [  671.318177] time_bench: Type:kmem bulk_fallback Per elem: 192 cycles(tsc) 64.130 ns (step:158) - (measurement period time:0.641303389 sec time_interval:641303389) - (invoke count:9999978 tsc_interval:1920234600)
> [  671.417083] time_bench: Type:kmem bulk_quick_reuse Per elem: 29 cycles(tsc) 9.889 ns (step:158) - (measurement period time:0.098890269 sec time_interval:98890269) - (invoke count:9999978 tsc_interval:296103210)
> [  671.700461] time_bench: Type:kmem bulk_fallback Per elem: 84 cycles(tsc) 28.334 ns (step:250) - (measurement period time:0.283346426 sec time_interval:283346426) - (invoke count:10000000 tsc_interval:848415660)
> [  671.965515] time_bench: Type:kmem bulk_quick_reuse Per elem: 79 cycles(tsc) 26.502 ns (step:250) - (measurement period time:0.265021064 sec time_interval:265021064) - (invoke count:10000000 tsc_interval:793543500)
> 
> [  686.749446] time_bench: Type:for_loop Per elem: 1 cycles(tsc) 0.660 ns (step:0) - (measurement period time:0.066028480 sec time_interval:66028480) - (invoke count:100000000 tsc_interval:197707140)
> [  687.296902] time_bench: Type:kmem fastpath reuse Per elem: 163 cycles(tsc) 54.742 ns (step:0) - (measurement period time:0.547423736 sec time_interval:547423736) - (invoke count:10000000 tsc_interval:1639141260)
> [  687.910620] time_bench: Type:kmem bulk_fallback Per elem: 183 cycles(tsc) 61.369 ns (step:1) - (measurement period time:0.613692564 sec time_interval:613692564) - (invoke count:10000000 tsc_interval:1837568160)
> [  688.381090] time_bench: Type:kmem bulk_quick_reuse Per elem: 140 cycles(tsc) 47.045 ns (step:1) - (measurement period time:0.470452576 sec time_interval:470452576) - (invoke count:10000000 tsc_interval:1408667550)
> [  688.662045] time_bench: Type:kmem bulk_fallback Per elem: 84 cycles(tsc) 28.094 ns (step:2) - (measurement period time:0.280943997 sec time_interval:280943997) - (invoke count:10000000 tsc_interval:841225230)
> [  688.817464] time_bench: Type:kmem bulk_quick_reuse Per elem: 46 cycles(tsc) 15.540 ns (step:2) - (measurement period time:0.155409002 sec time_interval:155409002) - (invoke count:10000000 tsc_interval:465337980)
> [  689.094749] time_bench: Type:kmem bulk_fallback Per elem: 83 cycles(tsc) 27.723 ns (step:3) - (measurement period time:0.277235751 sec time_interval:277235751) - (invoke count:9999999 tsc_interval:830122170)
> [  689.225706] time_bench: Type:kmem bulk_quick_reuse Per elem: 39 cycles(tsc) 13.091 ns (step:3) - (measurement period time:0.130919113 sec time_interval:130919113) - (invoke count:9999999 tsc_interval:392008440)
> [  689.988861] time_bench: Type:kmem bulk_fallback Per elem: 228 cycles(tsc) 76.314 ns (step:4) - (measurement period time:0.763146670 sec time_interval:763146670) - (invoke count:10000000 tsc_interval:2285076870)
> [  690.274210] time_bench: Type:kmem bulk_quick_reuse Per elem: 85 cycles(tsc) 28.532 ns (step:4) - (measurement period time:0.285320525 sec time_interval:285320525) - (invoke count:10000000 tsc_interval:854329500)
> [  690.862234] time_bench: Type:kmem bulk_fallback Per elem: 176 cycles(tsc) 58.799 ns (step:8) - (measurement period time:0.587998540 sec time_interval:587998540) - (invoke count:10000000 tsc_interval:1760633010)
> [  690.964020] time_bench: Type:kmem bulk_quick_reuse Per elem: 30 cycles(tsc) 10.171 ns (step:8) - (measurement period time:0.101718599 sec time_interval:101718599) - (invoke count:10000000 tsc_interval:304573500)
> [  691.245251] time_bench: Type:kmem bulk_fallback Per elem: 84 cycles(tsc) 28.122 ns (step:16) - (measurement period time:0.281223369 sec time_interval:281223369) - (invoke count:10000000 tsc_interval:842060850)
> [  691.341256] time_bench: Type:kmem bulk_quick_reuse Per elem: 28 cycles(tsc) 9.599 ns (step:16) - (measurement period time:0.095990014 sec time_interval:95990014) - (invoke count:10000000 tsc_interval:287420100)
> [  691.616379] time_bench: Type:kmem bulk_fallback Per elem: 82 cycles(tsc) 27.511 ns (step:30) - (measurement period time:0.275116534 sec time_interval:275116534) - (invoke count:9999990 tsc_interval:823776390)
> [  691.710275] time_bench: Type:kmem bulk_quick_reuse Per elem: 28 cycles(tsc) 9.388 ns (step:30) - (measurement period time:0.093884613 sec time_interval:93884613) - (invoke count:9999990 tsc_interval:281115990)
> [  691.982082] time_bench: Type:kmem bulk_fallback Per elem: 81 cycles(tsc) 27.180 ns (step:32) - (measurement period time:0.271800767 sec time_interval:271800767) - (invoke count:10000000 tsc_interval:813847530)
> [  692.077384] time_bench: Type:kmem bulk_quick_reuse Per elem: 28 cycles(tsc) 9.526 ns (step:32) - (measurement period time:0.095266005 sec time_interval:95266005) - (invoke count:10000000 tsc_interval:285252780)
> [  692.348422] time_bench: Type:kmem bulk_fallback Per elem: 81 cycles(tsc) 27.102 ns (step:34) - (measurement period time:0.271026511 sec time_interval:271026511) - (invoke count:9999978 tsc_interval:811529490)
> [  692.440805] time_bench: Type:kmem bulk_quick_reuse Per elem: 27 cycles(tsc) 9.236 ns (step:34) - (measurement period time:0.092368535 sec time_interval:92368535) - (invoke count:9999978 tsc_interval:276576810)
> [  692.712439] time_bench: Type:kmem bulk_fallback Per elem: 81 cycles(tsc) 27.162 ns (step:48) - (measurement period time:0.271619761 sec time_interval:271619761) - (invoke count:9999984 tsc_interval:813305970)
> [  692.945558] time_bench: Type:kmem bulk_quick_reuse Per elem: 69 cycles(tsc) 23.309 ns (step:48) - (measurement period time:0.233091977 sec time_interval:233091977) - (invoke count:9999984 tsc_interval:697942470)
> [  693.234591] time_bench: Type:kmem bulk_fallback Per elem: 86 cycles(tsc) 28.902 ns (step:64) - (measurement period time:0.289021416 sec time_interval:289021416) - (invoke count:10000000 tsc_interval:865411350)
> [  693.326142] time_bench: Type:kmem bulk_quick_reuse Per elem: 27 cycles(tsc) 9.153 ns (step:64) - (measurement period time:0.091539475 sec time_interval:91539475) - (invoke count:10000000 tsc_interval:274094220)
> [  693.615858] time_bench: Type:kmem bulk_fallback Per elem: 86 cycles(tsc) 28.970 ns (step:128) - (measurement period time:0.289709207 sec time_interval:289709207) - (invoke count:10000000 tsc_interval:867470400)
> [  693.717321] time_bench: Type:kmem bulk_quick_reuse Per elem: 30 cycles(tsc) 10.145 ns (step:128) - (measurement period time:0.101451019 sec time_interval:101451019) - (invoke count:10000000 tsc_interval:303772410)
> [  694.000375] time_bench: Type:kmem bulk_fallback Per elem: 84 cycles(tsc) 28.304 ns (step:158) - (measurement period time:0.283047625 sec time_interval:283047625) - (invoke count:9999978 tsc_interval:847523850)
> [  694.108588] time_bench: Type:kmem bulk_quick_reuse Per elem: 32 cycles(tsc) 10.816 ns (step:158) - (measurement period time:0.108168257 sec time_interval:108168257) - (invoke count:9999978 tsc_interval:323885820)
> [  694.392070] time_bench: Type:kmem bulk_fallback Per elem: 84 cycles(tsc) 28.344 ns (step:250) - (measurement period time:0.283447055 sec time_interval:283447055) - (invoke count:10000000 tsc_interval:848719800)
> [  694.655226] time_bench: Type:kmem bulk_quick_reuse Per elem: 78 cycles(tsc) 26.312 ns (step:250) - (measurement period time:0.263123465 sec time_interval:263123465) - (invoke count:10000000 tsc_interval:787864230)
> 


