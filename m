Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52296C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CED20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7QUWfZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgCPIPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:15:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41809 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbgCPIPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:15:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id s11so13290643qks.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 01:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F/i4UURiGEiDmJWiySfSNZr+o1KHFsCHgdng66n03Q0=;
        b=B7QUWfZ2p0iHwX6wNgX6U4yztQAMGDAiU1KFSHsaBYgSKDV+Kdl+8H155Lfmbg+9o/
         TxGbcBBwEqOPQ/B/w6jAG6N0rUQpjSNA+s/F/Tud+SRpVnYFph4gVet/kfh28qnd9zQt
         +zSo6COsT5fR35kjG2HJUXBsYVrX9cRZUknKCS7W5sr1GYRTBMEC1QpOzQ7viSl+n2pN
         cGaEg2tPimuaF7sbPikYKrNGerAbRU77SHD6nW+mqtjD7aZXVr2oYClwzswetpGkUdY6
         ldrXWz4oCSqcw2vqUL3VtrVAEe7+21fSUUt9pt7RqkY8U0lRZc6KjarLjC7fRfr6wPSh
         YpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F/i4UURiGEiDmJWiySfSNZr+o1KHFsCHgdng66n03Q0=;
        b=ptw+E/+r3i5pzGi6HvTp3aQqPPbWPXqbJyhzxjBf0bOs/EjNF3a3Dl2rUbtpwJFlFJ
         eNSZsS6aE00aKhm0m/nEq5rN1LKMzT3IxLsnsuTe26Pl2GqIg2kdIOc3WF+FV2PD3/dA
         kjAl9nnP9LkeTCsOqx+NgmmsvBnydar2IzwEz9OUczCEw6iSjXOiQzuZdO4TpNf8CM76
         wDgBuAHu02gnTxaL7FMlxX4bNYxCmEUS4st9ZyvSat+zEC1/m68ytG4ttaAwSFz7FPv8
         C6/3y/IB5WwntbejrEspm9XOGWf4EBagavzArzMkDihRyXIcgtVI+QGk7LcAUSRal/Sg
         YACg==
X-Gm-Message-State: ANhLgQ2YCF7mIuiewOSZtIN4Nhm60evSemWV+7GzUJdQYZ9j13EhIIjT
        XIIIKl6hyyDdPPLoretcmzNIFKxxfYPtO7VKXMg=
X-Google-Smtp-Source: ADFU+vtuhvzirDhMCsmE4l39TWh2tgFAp6304DDB1OcJOZvmemJgfuS7i39szr9xiMsVL2Kk2XCoJDL/oQcWR3C4GH0=
X-Received: by 2002:a37:546:: with SMTP id 67mr24213408qkf.272.1584346530319;
 Mon, 16 Mar 2020 01:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200311110237.5731-2-srikar@linux.vnet.ibm.com>
 <20200311115735.GM23944@dhcp22.suse.cz> <20200312052707.GA3277@linux.vnet.ibm.com>
 <C5560C71-483A-41FB-BDE9-526F1E0CFA36@linux.vnet.ibm.com> <5e5c736a-a88c-7c76-fc3d-7bc765e8dcba@suse.cz>
 <20200312131438.GB3277@linux.vnet.ibm.com> <61437352-8b54-38fa-4471-044a65c9d05a@suse.cz>
 <20200312161310.GC3277@linux.vnet.ibm.com> <e115048c-be38-c298-b8d1-d4b513e7d2fb@suse.cz>
 <CAAmzW4OFy51BhAT62tdVQD52NNMWm+UPgoGAX97omY7P+nJ+5w@mail.gmail.com>
 <20200313110440.GA25144@linux.vnet.ibm.com> <06be5908-9af6-2892-0333-e9558b2cf474@suse.cz>
In-Reply-To: <06be5908-9af6-2892-0333-e9558b2cf474@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 16 Mar 2020 17:15:19 +0900
Message-ID: <CAAmzW4ME_WLYZPCt4+82RNKstv-H=LK5MKGGJR=6ha-ALS+FSw@mail.gmail.com>
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
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 3=EC=9B=94 13=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 8:38, V=
lastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 3/13/20 12:04 PM, Srikar Dronamraju wrote:
> >> I lost all the memory about it. :)
> >> Anyway, how about this?
> >>
> >> 1. make node_present_pages() safer
> >> static inline node_present_pages(nid)
> >> {
> >> if (!node_online(nid)) return 0;
> >> return (NODE_DATA(nid)->node_present_pages);
> >> }
> >>
> >
> > Yes this would help.
>
> Looks good, yeah.
>
> >> 2. make node_to_mem_node() safer for all cases
> >> In ppc arch's mem_topology_setup(void)
> >> for_each_present_cpu(cpu) {
> >>  numa_setup_cpu(cpu);
> >>  mem_node =3D node_to_mem_node(numa_mem_id());
> >>  if (!node_present_pages(mem_node)) {
> >>   _node_numa_mem_[numa_mem_id()] =3D first_online_node;
> >>  }
> >> }
> >>
> >
> > But here as discussed above, we miss the case of possible but not prese=
nt nodes.
> > For such nodes, the above change may not update, resulting in they stil=
l
> > having 0. And node 0 can be only possible but not present.

Oops, I don't read full thread so miss the case.

> So is there other way to do the setup so that node_to_mem_node() returns =
an
> online+present node when called for any possible node?

Two changes seems to be sufficient.

1. initialize all node's _node_numa_mem_[] =3D first_online_node in
mem_topology_setup()
2. replace the node with online+present node for _node_to_mem_node_[]
in set_cpu_numa_mem().

 static inline void set_cpu_numa_mem(int cpu, int node)
 {
        per_cpu(_numa_mem_, cpu) =3D node;
+       if (!node_present_pages(node))
+               node =3D first_online_node;
        _node_numa_mem_[cpu_to_node(cpu)] =3D node;
 }
 #endif

With these two change, we can safely call node_to_mem_node() anywhere.

Thanks.
