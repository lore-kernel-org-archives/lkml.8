Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0B7C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB70206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idV80ylM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgCMJsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:48:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43225 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgCMJsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:48:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id l13so6922286qtv.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8ype9a2Pgy0TDkVr+jjtxMr6KTyOlymmisvMN8Riefk=;
        b=idV80ylMvEIMsvllcp2OWlep7Wg7lp0Ru/uKDyRC6qmc69JFzVeRgtSHUhR+D59WlM
         AoU7d3uKDNnIU1L8At21wB0rJIG17hd5BoXi5lLqgMBGnmwOMs8blHzdVC04jvi6xYui
         VIoMUsD22lhwAoWHU8w/iRpsazyrL77UIBOQZ7O0YewBF3lH5V3AYjrSvFPWYyu6I4Dz
         lmIpRCuLy0T/8xJY2bLzVqt7BVGuMqfPhBVGymY4PMzaxnf3FAOI9ltIzrUHPQFGt6xC
         foq4mOfumN0EfS2Z3VkXuD11EFgNuPjWhxsAjPbmAMIGuFGisI46U2A4qBu9rYkKJwnb
         bZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8ype9a2Pgy0TDkVr+jjtxMr6KTyOlymmisvMN8Riefk=;
        b=ZewLMj73eFierun+idORHVHh7UvbRl6wkze2xjs00NZ4vRiodGTYKZm3frsQloRKRm
         z96a8nxh3q3s2DAhNQAhrotgzdjVd+SbOc30ZIN3ZzN5g+KmQtUrU5nyJ2jjJAdMez/q
         Sjqd1m6BrKkdKTIUD8xmqZoJffHgTH1osC5/7/1AyD/uyWkSSrPia4RkgzygWQcYT2Mu
         zxpDrooNbJ9t4PMEkcgtGQ54d6qoQWAiO4LON7bIMVBIZvbTxcgc75VnLPsojQ15Ysd7
         wJZqMW6THmRVVH/blmoZDV7aiHBf+f27GYKVkN8eK5QWj5fq+VexeTPRF6mcm4zzj6ER
         f0Bg==
X-Gm-Message-State: ANhLgQ2v9GjBcqPuZt6r8u09mpjPPRZXwjWwk8SmXw3lEZ8grfON/Q+b
        Mz36T1oLbYrGYE8Wq/oHXumKFUs1OyRFULN+8jM=
X-Google-Smtp-Source: ADFU+vtE7WMgh4Gv9w102cDFerGRE1K1vCLoXgu1/Vg4RBcxs88YSkurvuT2VTjzFld7v8QADYo+l0oWYGQvFcjPMK8=
X-Received: by 2002:aed:3346:: with SMTP id u64mr4634827qtd.333.1584092880504;
 Fri, 13 Mar 2020 02:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200311110237.5731-1-srikar@linux.vnet.ibm.com>
 <20200311110237.5731-2-srikar@linux.vnet.ibm.com> <20200311115735.GM23944@dhcp22.suse.cz>
 <20200312052707.GA3277@linux.vnet.ibm.com> <C5560C71-483A-41FB-BDE9-526F1E0CFA36@linux.vnet.ibm.com>
 <5e5c736a-a88c-7c76-fc3d-7bc765e8dcba@suse.cz> <20200312131438.GB3277@linux.vnet.ibm.com>
 <61437352-8b54-38fa-4471-044a65c9d05a@suse.cz> <20200312161310.GC3277@linux.vnet.ibm.com>
 <e115048c-be38-c298-b8d1-d4b513e7d2fb@suse.cz>
In-Reply-To: <e115048c-be38-c298-b8d1-d4b513e7d2fb@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 13 Mar 2020 18:47:49 +0900
Message-ID: <CAAmzW4OFy51BhAT62tdVQD52NNMWm+UPgoGAX97omY7P+nJ+5w@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc/numa: Set numa_node for all possible cpus
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christopher Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 3=EC=9B=94 13=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 1:42, V=
lastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 3/12/20 5:13 PM, Srikar Dronamraju wrote:
> > * Vlastimil Babka <vbabka@suse.cz> [2020-03-12 14:51:38]:
> >
> >> > * Vlastimil Babka <vbabka@suse.cz> [2020-03-12 10:30:50]:
> >> >
> >> >> On 3/12/20 9:23 AM, Sachin Sant wrote:
> >> >> >> On 12-Mar-2020, at 10:57 AM, Srikar Dronamraju <srikar@linux.vne=
t.ibm.com> wrote:
> >> >> >> * Michal Hocko <mhocko@kernel.org> [2020-03-11 12:57:35]:
> >> >> >>> On Wed 11-03-20 16:32:35, Srikar Dronamraju wrote:
> >> >> >>>> To ensure a cpuless, memoryless dummy node is not online, powe=
rpc need
> >> >> >>>> to make sure all possible but not present cpu_to_node are set =
to a
> >> >> >>>> proper node.
> >> >> >>>
> >> >> >>> Just curious, is this somehow related to
> >> >> >>> http://lkml.kernel.org/r/20200227182650.GG3771@dhcp22.suse.cz?
> >> >> >>>
> >> >> >>
> >> >> >> The issue I am trying to fix is a known issue in Powerpc since m=
any years.
> >> >> >> So this surely not a problem after a75056fc1e7c (mm/memcontrol.c=
: allocate
> >> >> >> shrinker_map on appropriate NUMA node").
> >> >> >>
> >> >
> >> > While I am not an expert in the slub area, I looked at the patch
> >> > a75056fc1e7c and had some thoughts on why this could be causing this=
 issue.
> >> >
> >> > On the system where the crash happens, the possible number of nodes =
is much
> >> > greater than the number of onlined nodes. The pdgat or the NODE_DATA=
 is only
> >> > available for onlined nodes.
> >> >
> >> > With a75056fc1e7c memcg_alloc_shrinker_maps, we end up calling kzall=
oc_node
> >> > for all possible nodes and in ___slab_alloc we end up looking at the
> >> > node_present_pages which is NODE_DATA(nid)->node_present_pages.
> >> > i.e for a node whose pdgat struct is not allocated, we are trying to
> >> > dereference.
> >>
> >> From what we saw, the pgdat does exist, the problem is that slab's per=
-node data
> >> doesn't exist for a node that doesn't have present pages, as it would =
be a waste
> >> of memory.
> >
> > Just to be clear
> > Before my 3 patches to fix dummy node:
> > srikar@ltc-zzci-2 /sys/devices/system/node $ cat $PWD/possible
> > 0-31
> > srikar@ltc-zzci-2 /sys/devices/system/node $ cat $PWD/online
> > 0-1
>
> OK
>
> >>
> >> Uh actually you are probably right, the NODE_DATA doesn't exist anymor=
e? In
> >> Sachin's first report [1] we have
> >>
> >> [    0.000000] numa:   NODE_DATA [mem 0x8bfedc900-0x8bfee3fff]
> >> [    0.000000] numa:     NODE_DATA(0) on node 1
> >> [    0.000000] numa:   NODE_DATA [mem 0x8bfed5200-0x8bfedc8ff]
> >>
> >
> > So even if pgdat would exist for nodes 0 and 1, there is no pgdat for t=
he
> > rest 30 nodes.
>
> I see. Perhaps node_present_pages(node) is not safe in SLUB then and it s=
hould
> check online first, as you suggested.
>
> >> But in this thread, with your patches Sachin reports:
> >
> > and with my patches
> > srikar@ltc-zzci-2 /sys/devices/system/node $ cat $PWD/possible
> > 0-31
> > srikar@ltc-zzci-2 /sys/devices/system/node $ cat $PWD/online
> > 1
> >
> >>
> >> [    0.000000] numa:   NODE_DATA [mem 0x8bfedc900-0x8bfee3fff]
> >>
> >
> > so we only see one pgdat.
> >
> >> So I assume it's just node 1. In that case, node_present_pages is real=
ly dangerous.
> >>
> >> [1]
> >> https://lore.kernel.org/linux-next/3381CD91-AB3D-4773-BA04-E7A072A6396=
8@linux.vnet.ibm.com/
> >>
> >> > Also for a memoryless/cpuless node or possible but not present nodes=
,
> >> > node_to_mem_node(node) will still end up as node (atleast on powerpc=
).
> >>
> >> I think that's the place where this would be best to fix.
> >>
> >
> > Maybe. I thought about it but the current set_numa_mem semantics are ap=
t
> > for memoryless cpu node and not for possible nodes.  We could have upto=
 256
> > possible nodes and only 2 nodes (1,2) with cpu and 1 node (1) with memo=
ry.
> > node_to_mem_node seems to return what is set in set_numa_mem().
> > set_numa_mem() seems to say set my numa_mem node for the current memory=
less
> > node to the param passed.
> >
> > But how do we set numa_mem for all the other 253 possible nodes, which
> > probably will have 0 as default?
> >
> > Should we introduce another API such that we could update for all possi=
ble
> > nodes?
>
> If we want to rely on node_to_mem_node() to give us something safe for ea=
ch
> possible node, then probably it would have to be like that, yeah.
>
> >> > I tried with this hunk below and it works.
> >> >
> >> > But I am not sure if we need to check at other places were
> >> > node_present_pages is being called.
> >>
> >> I think this seems to defeat the purpose of node_to_mem_node()? Should=
n't it
> >> return only nodes that are online with present memory?
> >> CCing Joonsoo who seems to have introduced this in ad2c8144418c ("topo=
logy: add
> >> support for node_to_mem_node() to determine the fallback node")
> >>
> >
> > Agree

I lost all the memory about it. :)
Anyway, how about this?

1. make node_present_pages() safer
static inline node_present_pages(nid)
{
if (!node_online(nid)) return 0;
return (NODE_DATA(nid)->node_present_pages);
}

2. make node_to_mem_node() safer for all cases
In ppc arch's mem_topology_setup(void)
for_each_present_cpu(cpu) {
 numa_setup_cpu(cpu);
 mem_node =3D node_to_mem_node(numa_mem_id());
 if (!node_present_pages(mem_node)) {
  _node_numa_mem_[numa_mem_id()] =3D first_online_node;
 }
}

With these two changes, we can uses node_present_pages() and node_to_mem_no=
de()
as intended.

Thanks.

> >> I think we do need well defined and documented rules around node_to_me=
m_node(),
> >> cpu_to_node(), existence of NODE_DATA, various node_states bitmaps etc=
 so
> >> everyone handles it the same, safe way.
>
> So let's try to brainstorm how this would look like? What I mean are some=
 rules
> like below, even if some details in my current understanding are most lik=
ely
> incorrect:
>
> with nid present in:
> N_POSSIBLE - pgdat might not exist, node_to_mem_node() must return some o=
nline
> node with memory so that we don't require everyone to search for it in sl=
ightly
> different ways
> N_ONLINE - pgdat must exist, there doesn't have to be present memory,
> node_to_mem_node() still has to return something else (?)
> N_NORMAL_MEMORY - there is present memory, node_to_mem_node() returns its=
elf
> N_HIGH_MEMORY - node has present high memory
