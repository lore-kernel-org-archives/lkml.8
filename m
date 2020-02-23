Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C9FC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 20:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A453206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 20:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgBWUsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 15:48:06 -0500
Received: from mail-a09.ithnet.com ([217.64.83.104]:59642 "EHLO
        mail-a09.ithnet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbgBWUsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 15:48:04 -0500
Received: (qmail 9965 invoked by uid 0); 23 Feb 2020 20:48:01 -0000
Received: from skraw.ml@ithnet.com by mail-a09 
 (Processed in 3.228049 secs); 23 Feb 2020 20:48:01 -0000
X-Virus-Status: No
X-ExecutableContent: No
Received: from dialin014-sr.ithnet.com (HELO ithnet.com) (217.64.64.14)
  by mail-a09.ithnet.com with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 23 Feb 2020 20:47:57 -0000
X-Sender-Authentication: SMTP AUTH verified <skraw.ml@ithnet.com>
Date:   Sun, 23 Feb 2020 21:47:57 +0100
From:   Stephan von Krawczynski <skraw.ml@ithnet.com>
To:     whywontyousue@waifu.club
Cc:     linux-kernel@vger.kernel.org, rms@gnu.org, bruce@perens.com,
        bind-users@lists.isc.org
Subject: Re: General Discussion about GPLness
Message-ID: <20200223214757.5adf49e4@ithnet.com>
In-Reply-To: <dadb648cd23ee79dacf5992ff5ca6094@waifu.club>
References: <8b0e828da35ab77c1ad4603768c6eab6@waifu.club>
        <20200223133301.03eab91d@ithnet.com>
        <2241a3e0c8dcba5b69b4f670e181d7cd@waifu.club>
        <20200223153909.1ba91bae@ithnet.com>
        <dadb648cd23ee79dacf5992ff5ca6094@waifu.club>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, really it is quite hard to stay calm reading your constant insults on
people that have quite sure done a lot more for free software than you have.
I do understand why you cannot enter a discussion with your real name, as most
of your input is of zero quality - and below.
Unfortunately you did not even try to understand what the true issue is all
about. It is one story to modify running code that probably was never ment to
be patched that way (which would involve re-engineering it). But our story is
about kernel modules, something everybody is free to write and publish, with a
defined and open interface for interaction. No kernel code is modified in that
sense. But you fail to understand that.
Hopefully others here do. I do not expect them to stand up and jump into a
discussion where you are a part of. But I hope people start to think about it
and realise - like I did - that this train is on the wrong track.
After all I do believe that constructive interaction of software is still
better than destructive building of hurdles and walls.
Because in the end people are only suffering from this approach and nothing is
protected.
--
Regards,
Stephan





On Sun, 23 Feb 2020 16:24:28 +0000
whywontyousue@waifu.club wrote:

> I gave you an example of a court immediately finding that modifying a 
> running program is not allowed without permission. Creators of Non-gpl'd 
> programs don't have permission to interact with a GPL'd work by 
> modifying or extending it. If the principal stands for RealPlayer, it 
> stands for Linux.
> 
> The GPL is a copyright license; law is the domain this is in.
> 
> In the domain of programming: you can do whatever you want. No technical 
> measure is stopping you.
> 
> In the domain of what is "right and wrong" but excluding law, since you 
> mentioned it and thus opened the door. Well... YHWH allows men to have 
> female children as brides:
> >>>> The Torah explicitly allows men to marry female children, including 
> >>>> in cases of the rape (tahphas) of the girl child: Devarim chapter 
> >>>> 22, verse 28. Key words: Na'ar (child (hebrew masoretic text)), 
> >>>> Padia (child: padia+philos = paedophillia (greek septuagint)) Puella 
> >>>> (young girl (latin vulgate))
> >>>> Nachmanides points out that a child may be called na'ar from the 
> >>>> moment he is born.  
> White idiots (such as the Linux programmers like Linus Trovalds) do not: 
> White idiots worship white women. This is a problem for Free Software 
> because White idiots (like Linus Trovalds) will do /anything/ to make 
> money for "Muh whoite wuhman". That includes cowering in the face of 
> being "blackballed" from the industry if they DARE enforce their 
> copyrights.
> 
> In the domain of willpower: the linux copyright holders, atleast the 
> programmers who are copyright holders, are NOT going to sue you for 
> violating the copyright license permissions. They are pieces of shit who 
> don't believe in "Copyleft". They believe in the BSD license, and have 
> effectivly made Linux a BSD-type work since they never enforce the GPL.
> 
> OpenSourceSecurity (GRSecurity) is blatantly violating section 4 and 
> section 6 of the linux copyright license and the Linux copyright-owning 
> programmers would rather punish anyone who brings it up than sue the 
> violators.
> 
> They are weak feckless people: more concerned about making money for 
> "Muh wuhman" than anything else. Pay them no mind. They are scumbag 
> idiots who won't know what they had until it's gone (it is).
> 
> I think that covers all the topics, right?
> 
> So, by law may you do what you suggested: No: it is a copyright 
> violation in the US.
> Is anyTHING going to stop you: no.
> Is anyONE going to try to punish you for it: no.
> 
> Remember: linux copyright holders are either stupid white nerds (if they 
> were smart they would have listened to their parents and become doctors 
> and lawyers, and have tech as a fun hobby. Instead they are wageslaving 
> for "MUUH WHOITE WUUHHMAN": same as any white idiot worker)
> OR corporations who like the BSD license better.
> 
> You don't really have much to worry about. Because linux programmers are 
> what they are. Sheep that thought themselves lions after RMS' win vs 
> Cisco (that put the fear of the violating the copyright license (GPL in 
> that case) for awhile).
> 
> On 2020-02-23 14:39, Stephan von Krawczynski wrote:
> > Hello again,
> > 
> > at least you are beginning to sound a bit more like being able to 
> > discuss
> > something ;-)
> > The thing about a lawyer (I learned you are) is that they judge the 
> > world
> > according to lawsuits. You can learn from the history of my home 
> > country that
> > laws and courts are no measure for moral and right behaviour.
> > So my whole purpose of the thread is not to find out how the laws in 
> > the US
> > are judging something. It is all about how _we_ (we meaning all the 
> > people
> > contributing) are judging the issue. Do we really think that it is the 
> > right
> > thing to do to prevent people from feature-extending linux (and 
> > distros) in
> > general? The zfs case is special in that it is a simple "free license 
> > clash".
> > Which means all involved parties agree on the free and open software
> > principle, only the licenses (i.e. paper) disagree on the usage of it - 
> > to a
> > certain extent. But lets not discuss legal details. In the end it all 
> > comes up
> > to this simple question: what do we really want with the project?
> > Because in the end even you have to agree that there is a whole lot 
> > more world
> > outside the US. If people from other countries agree on something which 
> > gives
> > a better performance in some area, then the US would be the last ones 
> > not to
> > jump onto the train. Who can testify better than this project, not 
> > being
> > native-US.
> > Do we think it is illegal to call GPL code from non-GPL code? Yes or 
> > no,
> > simple choice.
> > Me, I don't think so. This is why I suggest we take down the barriers 
> > and
> > walls for interaction. It should be obvious by now that there will be 
> > no
> > non-gpl invasion taking place. Instead a non-ideological use of GPL may
> > convince even more people that free and open software is a good concept 
> > and
> > adds benefit to the world and does not _harm_ technological progress.
> > Given, not many people think about this from ground up before releasing
> > software on linux. This is probably the only reason why you can buy 
> > software
> > for linux at all. And maybe, only maybe, the lawyers in your beloved 
> > case
> > where too dumb to turn this case around and ask why the gpl linux 
> > software was
> > forced to marry with the non-gpl real player (which is/was available
> > for linux). According to this courts' point of view this must have been 
> > equally
> > illegal.
> > I mean it extended the gpl software with a new feature without checking 
> > for
> > gpl compliance.
> > As you can see the whole idea of the court in this case is broken. And 
> > it
> > seems only because noone asked the right questions.
> > --
> > Regards,
> > Stephan
> > 
> > 
> > 
> > On Sun, 23 Feb 2020 12:56:13 +0000
> > whywontyousue@waifu.club wrote:
> >   
> >> If you don't understand English, it will be difficult to get any 
> >> points
> >> across to you. I will try
> >> 
> >> In simple terms:
> >> 1) Look up the court case "Universal City Studios Inc v Reimerdes,"
> >> 
> >> 2) In this case someone else' software was running at the same time as
> >> the other persons software, and made changes, extensions _ONLY_ when
> >> running. Just like a non-gpl'd (or gpl'd) module might make changes 
> >> and
> >> extensions.
> >> 
> >> 3) The court found this was obviously a modification of the Copyright
> >> owners Work and barred in on summary judgement.
> >> 
> >> That is why you're not allowed to do as you wish with non-gpl'd 
> >> modules:
> >> the US Copyright Jurisprudence forbids marring a Copyright owners
> >> _running_ _in_memory_ property against his wishes: it's a Copyright
> >> violation.
> >> 
> >> That is the reason: people don't want to get sued. That is the ONLY
> >> reason. That's it.
> >> 
> >> The thing is, the linux copyright owners are wimps and won't sue 
> >> anyone
> >> even for blatant infringement; so what is the conversation about?
> >> 
> >> It's like if you were in Russia, and you were copying DVDs. No one is
> >> going to punish you for it: so what is there to discuss? The US
> >> Copyright owners don't have the rocks to Invade Russia, Start a 
> >> Nuclear
> >> Winter, and DESTROY you for your Copyright Infringement in Russia.
> >> 
> >> JUST AS, the DOG LIKE Linux Copyright owners don't have the BALLS to
> >> risk being blackballed from the programming industry for DEFENDING 
> >> THEIR
> >> COPYRIGHT.
> >> 
> >> The GPL ___IS___ dead. The FSF doesn't protect GCC copyright, and is
> >> opposed to taking any action against blantant in-writing infringers
> >> (OpenSourceSecurity (Grsecurity)) of GCC, just as the LINUX COMMUNITY 
> >> is
> >> OPPOSED to taking ANY action to defend its Copyrights and moves to
> >> PUNISH those rightsholders who do.
> >>   
> >> > And another thing: court is for lawyers. Whenever the lawyers take over
> >> > something they don't (want to) understand the end is near ...  
> >> 
> >> I'm a lawyer and a programmer, got something to say?
> >> 
> >>   
> >> > How about talking with real names?  
> >> Why would I do that? Tell me? What is in it for me?
> >> I can stand here, in the forest, taking shots at your bullshit. Safe.
> >> Secure. My words and their veracity the only measure.
> >> 
> >> But if I reveal the messanger; you'll just attack the messenger.
> >> Tell me how _I_ benifit from telling YOU my name. Tell me.
> >> Is it some sort of stupid werkin man white man bravado?
> >>   
> >> > I have no idea why you spam rms or bruce
> >> > with this, as the question is all about _one_ project, namely
> >> > linux-kernel.  
> >> 
> >> You sent a message to the LKML "Hey why can't I violate the GPL? Let's
> >> just do it!". IE: a licensing discussion. RMS and Bruce Perens, the
> >> founder of the Free Software Movement and the Open Source Initiative 
> >> are
> >> relevant parties to the discussion.
> >> 
> >>   
> >> > I'd suggest taking them off this topic again ...  
> >> You also suggested I reveal my identity on the internet...
> >> 
> >> 
> >> On 2020-02-23 12:33, Stephan von Krawczynski wrote:  
> >> > Dear whoeveryouare,
> >> >
> >> > can you please state in a clearer form (more understandable to
> >> > non-native
> >> > english talkers) what your true opinion on the topic is?
> >> > And in case you did not understand what I was saying, here is clearer
> >> > form of
> >> > my opinion:
> >> >
> >> > A kernel module with another license (be it whatsoever) is _no_
> >> > modification
> >> > of the kernel, but an extension of its features. If feature-extension
> >> > is
> >> > against the GPL (which I seriously doubt) then I would say "go back
> >> > onto your
> >> > trees". Because the human race and evolution is about little else than
> >> > feature-extension.
> >> >
> >> > And another thing: court is for lawyers. Whenever the lawyers take over
> >> > something they don't (want to) understand the end is near ...
> >> >
> >> > How about talking with real names? I have no idea why you spam rms or
> >> > bruce
> >> > with this, as the question is all about _one_ project, namely
> >> > linux-kernel.
> >> > I'd suggest taking them off this topic again ...
> >> >
> >> > --
> >> > Regards,
> >> > Stephan
> >> >
> >> >
> >> >
> >> > On Sun, 23 Feb 2020 11:03:56 +0000
> >> > whywontyousue@waifu.club wrote:
> >> >  
> >> >> Dear Stephan von Krawczynski;
> >> >>
> >> >> Universal City Studios Inc v Reimerdes, piece of shit.
> >> >>
> >> >> "[The court] reasoned that Ferret consumers who used the Ferret as a
> >> >> plug-in to the Real Player altered the Real Player user interface by
> >> >> adding the Snap search button or replacing it with the Stream box
> >> >> search
> >> >> engine button. The court concluded that the plaintiff raised
> >> >> sufficently
> >> >> serious questions going to the merits of its claims to warrant an
> >> >> injunction pending trial"
> >> >>
> >> >> Want to violate the linux kernel copyright, you fucking piece of shit?
> >> >> Yes you do. Yes modifying the running kernel with violating pieces is
> >> >> copyright infringement, you fucking piece of shit. Yes you should be
> >> >> sued. Just as Open Source Security (Grsecurity) should be sued for
> >> >> their
> >> >> violations (of section 4 and 6 of the linux kernel copyright license
> >> >> (they're also violating the GCC copyrights too)).
> >> >>
> >> >> Will they be sued? Will you be sued? No: Linux copyright holders are
> >> >> scared little wageslave worker bees. They aren't going to sue you;
> >> >> sorry. Why are you even announcing you intent to violate the
> >> >> copyright?
> >> >> Why even give these dogs such intellectual deference?
> >> >>
> >> >> I wish OpenSourceSecurity would be sued. I wish you would be sued. But
> >> >> linux WERKIN MAHN wage slave piece of shit idiots won't do it: I hate
> >> >> them much more than I hate the violators. Complete Dogs. They could
> >> >> move
> >> >> from strenght to strenght, from victory to victory; but they're scared
> >> >> for their "JEHRB"s. I have to say: white men are pathetic scum. If
> >> >> Linux
> >> >> was built by others there would rightfully be lawsuits.
> >> >>
> >> >>
> >> >>  
> >> >> > Stephan von Krawczynski wrote:
> >> >> > Hello all,
> >> >> >
> >> >> > you may have already heard about it or not (several times in the
> >> >> > past), non-kernel devices run into a symbol export problem as soon as
> >> >> > something is
> >> >> > only exported GPL from the kernel.
> >> >> > Currently there is a discussion regarding zfs using this call chain:
> >> >> >
> >> >> > vdev_bio_associate_blkg (zfs) -> blkg_tryget (kernel) ->
> >> >> > percpu_ref_tryget
> >> >> > (kernel) -> rcu_read_unlock (kernel) -> __rcu_read_unlock (kernel)
> >> >> >
> >> >> > where __rcu_read_[lock|unlock] is a GPL symbol now used by (not GPL
> >> >> > exported)
> >> >> > percpu_ref_tryget.
> >> >> >
> >> >> > That this popped up (again) made me think a bit more general about
> >> >> > the issue.
> >> >> > And I do wonder if this rather ideologic problem is on the right
> >> >> > track currently. Because what the kernel tries to do with the export
> >> >> > GPL symbol
> >> >> > stuff is to prevent any other licensed software from _using_ it in
> >> >> > _runtime_.
> >> >> > It does not try to prevent use/copy of the source code inside another
> >> >> > non-gpl
> >> >> > project.
> >> >> > And I do think that this is not the intention of GPL. If it were,
> >> >> > then 100% of
> >> >> > all mobile phones on this planet are illegal. All of them use GPL
> >> >> > software
> >> >> > from non-gpl software, be it kernel modules or apps - and I see no
> >> >> > difference
> >> >> > in the two. The constructed difference between kernel mode software
> >> >> > and user-space software is pure ideology. Because during runtime
> >> >> > everything is
> >> >> > just call-chained.
> >> >> > Which means if you fopen() a file in user-space it of course uses GPL
> >> >> > symbols
> >> >> > down in the chain somewhere. The contents of the opened file are not
> >> >> > heaven-sent.
> >> >> > If you/we follow the current completely ideology-driven GPL strategy
> >> >> > then I am
> >> >> > all for completely giving up this whole project. In real world you
> >> >> > simply
> >> >> > cannot use such a piece of software. The success of linux during the
> >> >> > last
> >> >> > years (i.e. decade) is not based on the pure GPL strategy, but on the
> >> >> > successful interaction between linux and non-GPL software.
> >> >> > Just think of the billions of smartphones all using a non-gpl
> >> >> > firmware (underneath, and there is no GPL version at all), the
> >> >> > kernel (with non-gpl
> >> >> > modules) and apps (quite some of which are non-gpl).
> >> >> > This is only one prominent example, but there are lots of others.
> >> >> > In the end it all sums up to one simple question:
> >> >> > Can one _use_ GPL software during runtime as a base for own projects
> >> >> > of any
> >> >> > license type or not? We are not talking about _copying_ gpl code, we
> >> >> > are
> >> >> > talking about runtime use.
> >> >> > If runtime use is generally allowed, then the export gpl symbol stuff
> >> >> > inside
> >> >> > the kernel code is nonsense. Because to use the kernel you must be
> >> >> > allowed to
> >> >> > call it, no matter from where.
> >> >> > Hit me.
> >> >> >
> >> >> > --
> >> >> > Regards,
> >> >> > Stephan  

